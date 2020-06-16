//
//  ArticleViewModel.swift
//  NYT
//
//  Created by Heba on 3/28/18.
//  Copyright © 2020 Heba. All rights reserved.
//

import UIKit


class ArticleViewModel {
        
    open var currentPageNumber : Int = 1;
    open var totalItemsCount : Int = 0;
    open var isFetchingNewData : Bool = false;

    //MARK:- Life Cycle
    init() {
        
    }
    
    //MARK:- Article Info
    class func getArticleTitle(article:NYTArticleElement?) -> String {
        
        var contentTitle = ""
        if article?.title != nil {
            contentTitle = article!.title!
        }
        
        return contentTitle
    }
    
    class func getArticleKeywords(article:NYTArticleElement?) -> String {
        
        var contentTitle = ""
        if article?.adxKeywords != nil {
            contentTitle = article!.adxKeywords!
        }
        
        return contentTitle
    }
    
    class func getArticleAbstract(article:NYTArticleElement?) -> String {
        
        var contentTitle = ""
        if article?.abstract != nil {
            contentTitle = article!.abstract!
        }
        
        return contentTitle
    }
    
    class func getDateValue(article:NYTArticleElement?) -> String {
        
        var dueDateSTR = ""
        dueDateSTR = article!.updated!
        
        return dueDateSTR
    }
    
    class func getAuthorValue(article:NYTArticleElement?) -> String {
        
        var dueDateSTR = ""
        dueDateSTR = article!.byline!
        
        return dueDateSTR
    }
    
    class func getArticleImageURL(article:NYTArticleElement?) -> String {
        
        var url = ""
        if article?.media?.count != 0 {
            
            let mediaObj = article?.media?.first
            print(mediaObj! )

            if mediaObj?.mediaMetadata != nil  {
                
                for metaDataObj in (mediaObj?.mediaMetadata)! {
                    
                    print(metaDataObj.url ?? "no url" )
                    if (metaDataObj.url != nil) {
                        url = metaDataObj.url ?? ""
                        break
                    }
                }
                
            }
        }
        
        return url
    }
    
    
    //MARK:- Mehods
    func openArticle(article:NYTArticleElement?)  {
        
        let topVC:UIViewController = ViewControllerUtils.getTopMostViewController(baseVC: nil)!

        ViewControllerUtils.pushDetailsVCOn(navigationController: topVC.navigationController!, with: article!, model: self)
    }
    
    //MARK:- APIs

    @IBAction func refreshData(refreshControl: UIRefreshControl?) {
        
        if isFetchingNewData {
            refreshControl?.endRefreshing()
            return;
        }
        
        isFetchingNewData = true

        self.getData(duration: 1, completionBlock: { (items) in
            
            refreshControl?.endRefreshing()
            self.currentPageNumber = 1;
            self.isFetchingNewData = false
        })
    }
    
    
    func getData(duration:Int, completionBlock: @escaping SucessBlock) {

        let topVC:UIViewController = ViewControllerUtils.getTopMostViewController(baseVC: nil)!

        ServerManager.shared.requestArticlesList(duration: duration, showLoader: true, showError: true, fromVC: topVC, completion: { (data, error) in
            
            
            if error != nil {
                AlertUtils.showErrorAlertWith(title: error!.localizedDescription, message: "", vc: topVC, actionBlock: {
                    
                })
            }
            else {
                completionBlock(data)
            }
        })
    }
}
