//
//  LoginViewController.swift
//  NYT
//
//  Created by Heba on 3/26/18.
//  Copyright © 2020 Heba. All rights reserved.
//

import UIKit
import Foundation
import SafariServices

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var mainView: UIView!

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateValueLabel: UILabel!
    
    @IBOutlet weak var keywordsView: UIView!
    @IBOutlet weak var keywordsLabel: UILabel!

    @IBOutlet weak var abstractView: UIView!
    @IBOutlet weak var abstractLabel: UILabel!

    @IBOutlet weak var showFullArticleButton: UIButton!

    var articlesViewModel:ArticleViewModel?
    var article:NYTArticleElement?
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.NYTTurquoiseColor()
        self.mainView.backgroundColor=UIColor.NYTBGColor()

        self.topView.backgroundColor=UIColor.NYTBGColor()
        self.keywordsView.backgroundColor=UIColor.NYTBGColor()
        self.abstractView.backgroundColor=UIColor.NYTBGColor()

        barView.backgroundColor = .NYTTurquoiseColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()

        self.updateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK:- View
    func updateView() {
        self.updateTopView()
        self.updateKeywordsView()
        self.updateAbstractView()
        
        showFullArticleButton.layer.cornerRadius = 5.0
    }
    
    func updateTopView() {
        let width = self.view.frame.width

        let titleText = ArticleViewModel.getArticleTitle(article: article)
        
        let titleFontSize=14.0 * width * UIFont.getFontFactor()
        let subFontSize=10.0 * width * UIFont.getFontFactor()

        titleLabel.numberOfLines = 4
        let labelAttrs = [NSAttributedString.Key.font : UIFont.NYTBoldFont().withSize(titleFontSize), NSAttributedString.Key.foregroundColor: UIColor.black]
        titleLabel.attributedText=NSAttributedString(string:  titleText, attributes: labelAttrs)

        let authorText = ArticleViewModel.getAuthorValue(article: article)
        let dateText = ArticleViewModel.getDateValue(article: article)

        let subLabelAttrs = [NSAttributedString.Key.font : UIFont.NYTRegularFont().withSize(subFontSize), NSAttributedString.Key.foregroundColor: UIColor.gray]
        authorLabel.attributedText=NSAttributedString(string:  authorText, attributes: subLabelAttrs)
        dateValueLabel.attributedText=NSAttributedString(string:  dateText, attributes: subLabelAttrs)
    }
    
    func updateKeywordsView() {
        
        let width = self.view.frame.width

        let titleText = "Keywords: \(ArticleViewModel.getArticleKeywords(article: article))"
        
        let keysFontSize=10.0 * width * UIFont.getFontFactor()

        let labelAttrs = [NSAttributedString.Key.font : UIFont.NYTItalicFont().withSize(keysFontSize), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        keywordsLabel.attributedText=NSAttributedString(string:  titleText, attributes: labelAttrs)
    }
    
    func updateAbstractView() {
        
        let width = self.view.frame.width

        let titleText = ArticleViewModel.getArticleAbstract(article: article)
        
        let textFontSize=14.0 * width * UIFont.getFontFactor()

        let labelAttrs = [NSAttributedString.Key.font : UIFont.NYTRegularFont().withSize(textFontSize), NSAttributedString.Key.foregroundColor: UIColor.black]
        abstractLabel.attributedText=NSAttributedString(string:  titleText, attributes: labelAttrs)
    }
    
    //MARK:- Actions
    @IBAction func backButtonIsPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func showFullArticle(_ sender: Any) {
        
        if let fullURL = article!.url {
            let url = URL(string: fullURL);

            let config = SFSafariViewController.Configuration()
            
            config.entersReaderIfAvailable = true
            
            let svc = SFSafariViewController.init(url: url!, configuration: config)
            svc.delegate = self
            self.present(svc, animated: true, completion: nil)
        }
        
        
    }
}

extension DetailsViewController: SFSafariViewControllerDelegate {
    
    //MARK:- SFSafariViewController Delegate
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true)
    }
}
