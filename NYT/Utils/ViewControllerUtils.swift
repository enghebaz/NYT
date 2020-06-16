//
//  ViewControllerUtils.swift
//  NYT
//
//  Created by heba on 6/11/20.
//  Copyright © 2020 Heba. All rights reserved.
//

import UIKit

class ViewControllerUtils: NSObject {

    class func getTopMostViewController(baseVC: UIViewController?) -> UIViewController? {
        
        var base:UIViewController?
        if baseVC == nil {
            
            if #available(iOS 13.0, *) {
                let scene = UIApplication.shared.connectedScenes.first
                if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                    base = sd.window!.rootViewController!
                }
            }
            else {
                        
                base = UIApplication.shared.keyWindow?.rootViewController!
            }
        }
        else {
            base = baseVC
        }
        
        if let nav = base as? UINavigationController {
            return getTopMostViewController(baseVC: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(baseVC: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(baseVC: presented)
        }
        return base
    }
    
    class func getPreviousVC(vc: UIViewController, navigationController:UINavigationController) -> UIViewController? {
        
        var previousVC:UIViewController = vc
        let index = navigationController.viewControllers.firstIndex(of: vc)
        
        if index != 0 {
            let preIndex = (index ?? 0) - 1
            previousVC = navigationController.viewControllers[preIndex]
        }
        
        return previousVC
    }
    
    // MARK:- Pushes
    class func pushListVCOn(navigationController:UINavigationController) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController:ListViewController = storyBoard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController

        navigationController.pushViewController(viewController, animated:true)
    }
    
    class func pushDetailsVCOn(navigationController:UINavigationController,with article:NYTArticleElement, model:ArticleViewModel) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController:DetailsViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        viewController.article = article
        viewController.articlesViewModel = model
        navigationController.pushViewController(viewController, animated:true)
    }
}


