//
//  APIHelper.swift
//  NYT
//
//  Created by Heba on 4/5/18.
//  Copyright © 2020 Heba. All rights reserved.
//

import UIKit
import MOLH
class APIHelper: NSObject {
    
    class func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    

    class func handleStatusCode(code:Int, apiName:String, response : HTTPURLResponse, data:Data?, completion: @escaping RequestCompletionBlock) {
            
        print("code",code);
        print("apiName",apiName);

        var msg = HTTPURLResponse.localizedString(forStatusCode: code) + "(\(apiName):\(code))"
        var apiCode = "(\(code))"

        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
            print("RESPONSE: \(jsonResult)")

            if let result: Dictionary<String, Any> = jsonResult as? Dictionary<String, Any> {
                let errorDict:Dictionary<String, Any> = result["error"] as! Dictionary<String, Any>
                
                var message = NSLocalizedString("GENERAL_ERROR_MESSAGE_TITLE", comment: "")
                if let text:String = errorDict["message"] as? String{
                    message = text
                    msg = "\(message)"
                }
                else {
                    msg = "\(message) (\(apiName):\(code))"
                }
                
                var errorCode:String = "\(code)"
                if let num:String = errorDict["code"] as? String {
                    errorCode = num
                }
                else if let num:Int = errorDict["code"] as? Int {
                    errorCode = "\(num)"
                }
                
                apiCode = "\(errorCode)"
            }
        }
        catch  {
            DispatchQueue.main.async {
                completion(nil,error);
            }
        }
        
        let error:NSError  = NSError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey : msg, NSLocalizedFailureReasonErrorKey : apiCode])
            
        let completionHandler: RequestCompletionBlock = {(response, error) in
            completion(nil,error);
        };
            
        DispatchQueue.main.async {
            completionHandler(nil,error);
        }
    }
    
    class func getAPI(path:String, body: Dictionary<String,Any>, completion: @escaping RequestCompletionBlock) {
        

        print("****************************")
        
        let URLString = "\(environment.url)\(path)?api-key=\(APIKey)"
        
        let url:URL = URL(string: URLString)!
        print(URLString)
        print("HTTP Method: GET")

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                
                print("HTTP Status: \(httpStatus.statusCode)")

                self.handleStatusCode(code: httpStatus.statusCode, apiName: url.lastPathComponent, response: httpStatus, data: data!, completion: completion)
            }
            else {
                
                print("HTTP Status: 200")

                if let error = error as NSError? {
                    
                    print("ERORR: \(error.localizedDescription)")

                    DispatchQueue.main.async {
                        completion(nil,error);
                    }
                    return
                }
                
                do {
//                    let str = String(decoding: data!, as: UTF8.self)
//                    print("RESPONSE STR: \(str)")

                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                    print("RESPONSE: \(jsonResult)")

                    guard let result: Dictionary<String, Any> = jsonResult as? Dictionary<String, Any> else {
                        
                        DispatchQueue.main.async {
                            completion(nil,nil);
                        }
                        return;
                    }
                    
                    DispatchQueue.main.async {
                        completion(result,error);
                    }
                }
                catch let error as NSError {
                    
                    let str = String(decoding: data!, as: UTF8.self)
                    print("RESPONSE STR: \(str)")
                    print("JSONSerialization ERROR : \(error.localizedDescription)")

                    DispatchQueue.main.async {
                        completion(nil,error);
                    }
                }
            }
        }
        task.resume()
    }

    class func postAPI(path:String, body: Dictionary<String,Any>,  completion: @escaping RequestCompletionBlock) {
        
        print("****************************")
        let URLString = "\(environment.url)\(path)?api-key=\(APIKey)"
        let url:URL = URL(string: URLString)!
        print(URLString)
        print("HTTP Method: POST")
        
        var request = URLRequest(url: url)
        request.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "POST"
        
        let postString = APIHelper.getPostString(params: body)
        print("BODY: \(postString)")

        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                
                print("HTTP Status: \(httpStatus.statusCode)")

                self.handleStatusCode(code: httpStatus.statusCode, apiName: url.lastPathComponent, response: httpStatus, data: data!, completion: completion)

            }
            else {
                
                print("HTTP Status: 200")

                if let error = error as NSError? {
                    
                    print("ERORR: \(error.localizedDescription)")

                    DispatchQueue.main.async {
                        completion(nil,error);
                    }
                    return
                }
                
                do {
//                    let str = String(decoding: data!, as: UTF8.self)
//                    print("RESPONSE STR: \(str)")

                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                    print("RESPONSE: \(jsonResult)")

                    guard let result: Dictionary<String, Any> = jsonResult as? Dictionary<String, Any> else {
                        
                        DispatchQueue.main.async {
                            completion(nil,nil);
                        }
                        return;
                    }
                    
                    DispatchQueue.main.async {
                        completion(result,error);
                    }
                }
                catch let error as NSError {
                    
                    print("JSONSerialization ERROR : \(error.localizedDescription)")

                    DispatchQueue.main.async {
                        completion(nil,error);
                    }
                }
            }
        }
        task.resume()
    }
    
    class func deleteAPI(path:String, body: Dictionary<String,Any>, addToken:Bool, completion: @escaping RequestCompletionBlock) {
            
            print("****************************")
            let URLString = "\(environment.url)\(path)?api-key=\(APIKey)"
            let url:URL = URL(string: URLString)!
            print(URLString)
            print("HTTP Method: DELETE")
            
            var request = URLRequest(url: url)
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            
            request.httpMethod = "DELETE"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    
                    print("HTTP Status: \(httpStatus.statusCode)")

                    self.handleStatusCode(code: httpStatus.statusCode, apiName: url.lastPathComponent, response: httpStatus, data: data!, completion: completion)

                }
                else {
                    
                    print("HTTP Status: 200")

                    if let error = error as NSError? {
                        
                        print("ERORR: \(error.localizedDescription)")

                        DispatchQueue.main.async {
                            completion(nil,error);
                        }
                        return
                    }
                    
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        print("RESPONSE: \(jsonResult)")

                        guard let result: Dictionary<String, Any> = jsonResult as? Dictionary<String, Any> else {
                            
                            DispatchQueue.main.async {
                                completion(nil,nil);
                            }
                            return;
                        }
                        
                        DispatchQueue.main.async {
                            completion(result,error);
                        }
                    }
                    catch let error as NSError {
                        
                        print("JSONSerialization ERROR : \(error.localizedDescription)")

                        DispatchQueue.main.async {
                            completion(nil,error);
                        }
                    }
                }
            }
            task.resume()
        }
    
}
