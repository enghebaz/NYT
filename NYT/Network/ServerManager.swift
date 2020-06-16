//
//  ServerManager.swift
//  NYT
//
//  Created by Heba on 5/8/18.
//  Copyright © 2020 Heba. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ServerManager{
    
    //MARK:- Initilization
    static let shared = ServerManager();
    
    private init() {
    }
    
    //MARK:- Refresh
    func refreshAppInfo(completion: @escaping RequestCompletionBlock) {
        
        let topVC:UIViewController = ViewControllerUtils.getTopMostViewController(baseVC: nil)!

        self.requestArticlesList(duration: 7, showLoader: false, showError: false, fromVC: topVC, completion: completion)
    }
    
    //MARK:- Clean
    func cleanUserData (){
                
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    

    //MARK:- Helpers
    func handleAPIResponse(response:Any?, error:Error?, showLoader:Bool, showError:Bool, fromVC:UIViewController, completion: @escaping RequestCompletionBlock) {
        

        if (error != nil) {
            
            if showLoader {
                MBProgressManager.shared.hideProgrss(vc: fromVC)
            }
            
            if showError {
                
                AlertUtils.showErrorAlertWith(title: error!.localizedDescription, message: "", vc: fromVC) {
                    
                }
            }
            
            completion(nil,error)
            print("****************************")
        }
        else {
            
            let responseDict : Dictionary<String, Any> = (response as? Dictionary<String, Any>)!

            if responseDict["fault"] != nil {
                
                let errorDict: Dictionary<String, String> = responseDict["fault"] as! Dictionary<String, String>
                let status:String = (errorDict["faultstring"])!

                let errorMessage:String = "\(NSLocalizedString("GENERAL_ERROR_MESSAGE", comment: "")) (\(status):400)"
                
                if showLoader {
                    MBProgressManager.shared.hideProgrss(vc: fromVC)
                }
                
                if showError {
                    
                    AlertUtils.showErrorAlertWith(title: errorMessage, message: "", vc: fromVC) {
                        
                    }
                }
                
                let specialError:NSError  = NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey : errorMessage, NSLocalizedFailureReasonErrorKey : "400"])

                completion(nil,specialError)
                print("****************************")

            }
            else {
                var status:String = ""

                if responseDict["status"] != nil {
                    status = (responseDict["status"] as? String)!
                }

                                
                if status == "OK"{
                    completion(status,nil)
                }
            }
        }
    }
    
    //MARK:- General
    func requestArticlesList(duration:Int,showLoader:Bool, showError:Bool, fromVC:UIViewController, completion: @escaping RequestCompletionBlock) {
        
        if showLoader {
            MBProgressManager.shared.showProgress(vc: fromVC)
        }
        
        
        APIHelper.getAPI(path: "viewed/\(duration).json", body: [:]) { (result, error) in
            
            self.handleAPIResponse(response: result, error: error, showLoader: showLoader, showError: showError, fromVC: fromVC, completion: { (status,error)  in
                
                
                let responseDict:Dictionary<String, Any> = (result as? Dictionary<String, Any>)!
                let dataArray:Array<Dictionary<String, Any>> = responseDict["results"] as! Array<Dictionary<String, Any>>;

                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dataArray, options: .withoutEscapingSlashes)
                    
                    let jsonDecocoder = JSONDecoder()
                    let items = try jsonDecocoder.decode([NYTArticleElement].self, from: jsonData)

                    completion(items,error)

                }
                catch {
                    print(error.localizedDescription)
                    completion(nil,error)
                }

                if showLoader {
                    MBProgressManager.shared.hideProgrss(vc: fromVC)
                }
                print("****************************")
            })
        }
    }

}


