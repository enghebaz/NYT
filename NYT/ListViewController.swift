//
//  LoginViewController.swift
//  NYT
//
//  Created by Heba on 3/26/18.
//  Copyright © 2020 Heba. All rights reserved.
//

import UIKit
import Foundation

class ListViewController: UIViewController {
    
    open var emptyImageName : String = "BIG-Wifi";
    open var emptyLabelString : String = NSLocalizedString("NO_DATA", comment: "");
    open var emptyLabelTitleString : String = NSLocalizedString("NO_DATA", comment: "");

    open var cellHeight : CGFloat = 100.0;
    open var spaceInBetweenCell : CGFloat = 2;

    open var selectedPeriod : Int = 1;


    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var mainView: UIView!

    var emptyView: UIView!
    var holderView: UIView!
    var emptyImageView: UIImageView!
    var emptyTitleLabel: UILabel!
    var emptyLabel: UILabel!

    var articlesViewModel:ArticleViewModel = .init()
    var articlesArray:[NYTArticleElement] = []
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.NYTTurquoiseColor()
        self.mainView.backgroundColor=UIColor.NYTBGColor()

        barView.backgroundColor = .NYTTurquoiseColor()
        listCollectionView.backgroundColor=UIColor.clear
        
        self.initCollectionView()
        self.intializeEmptyView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()

        self.cellHeight = self.view.frame.size.height * 0.16

        self.updateEmptyView()
        self.articlesViewModel.getData(duration: selectedPeriod) { (items) in
            self.articlesArray = items as! [NYTArticleElement]
            self.listCollectionView.reloadData()
        }
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK:- Views
    func initCollectionView(){
            
        listCollectionView.bounces = true

        listCollectionView.delegate = self;
        listCollectionView.dataSource = self;

//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
//        listCollectionView.backgroundColor=UIColor.NYTBGColor()
//        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
//        {
//            listCollectionView.backgroundColor=UIColor.clear
//        }
//        listCollectionView.refreshControl = refreshControl

        
        listCollectionView.backgroundColor=UIColor.clear
        ViewUtils.updateViewWithShadow(view: listCollectionView)
        
        listCollectionView.tintColor=UIColor.NYTTurquoiseColor()

        listCollectionView.alwaysBounceVertical = true
    }
        

    
    func intializeEmptyView () {
        
        emptyView = UIView.init(frame: .zero)
        emptyView.backgroundColor = .clear
        listCollectionView.superview?.addSubview(emptyView)
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: emptyView!, attribute: .leading, relatedBy: .equal, toItem: listCollectionView, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: emptyView!, attribute: .trailing, relatedBy: .equal, toItem: listCollectionView, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: emptyView!, attribute: .top, relatedBy: .equal, toItem: listCollectionView, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: emptyView!, attribute: .bottom, relatedBy: .equal, toItem: listCollectionView, attribute: .bottom, multiplier: 1, constant: 0)
        listCollectionView.superview!.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        listCollectionView.superview!.sendSubviewToBack(emptyView)
        
        holderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        holderView.backgroundColor = .clear
        emptyView.addSubview(holderView)

        emptyImageView = UIImageView.init(frame: .zero)
        emptyImageView.contentMode = .scaleAspectFit
        holderView.addSubview(emptyImageView)
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false

        emptyLabel = UILabel.init(frame: .zero)
        emptyLabel.numberOfLines = 0
        emptyLabel.lineBreakMode = .byWordWrapping
        emptyLabel.textAlignment = .center
        holderView.addSubview(emptyLabel)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emptyTitleLabel = UILabel.init(frame: .zero)
        emptyTitleLabel.numberOfLines = 0
        emptyTitleLabel.lineBreakMode = .byWordWrapping
        emptyTitleLabel.textAlignment = .center
        holderView.addSubview(emptyTitleLabel)
        emptyTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        let imageSizeFactor:CGFloat = 0.4
        
        let imageWidthConstraint = NSLayoutConstraint(item: emptyImageView!, attribute: .width, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .width, multiplier: imageSizeFactor, constant: 0)
        NSLayoutConstraint.activate([imageWidthConstraint])
        
        
        let topImageConstraint = NSLayoutConstraint(item: emptyImageView!, attribute: .top, relatedBy: .equal, toItem: holderView!, attribute: .top, multiplier: 1, constant: 10.0)
        let imageCenterXConstraint = NSLayoutConstraint(item: emptyImageView!, attribute: .centerX, relatedBy: .equal, toItem: holderView, attribute: .centerX, multiplier: 1, constant: 0)
        let topLabelConstraint = NSLayoutConstraint(item: emptyTitleLabel!, attribute: .top, relatedBy: .equal, toItem: emptyImageView!, attribute: .bottom, multiplier: 1, constant: 10.0)
        let labelWidthConstraint = NSLayoutConstraint(item: emptyTitleLabel!, attribute: .width, relatedBy: .equal, toItem: holderView!, attribute: .width, multiplier: 0.9, constant: 0)
        let labelCenterXConstraint = NSLayoutConstraint(item: emptyTitleLabel!, attribute: .centerX, relatedBy: .equal, toItem: holderView, attribute: .centerX, multiplier: 1, constant: 0)
        let topDescLabelConstraint = NSLayoutConstraint(item: emptyLabel!, attribute: .top, relatedBy: .equal, toItem: emptyTitleLabel!, attribute: .bottom, multiplier: 1, constant: 10.0)
        let bottomDescLabelConstraint = NSLayoutConstraint(item: emptyLabel!, attribute: .bottom, relatedBy: .equal, toItem: holderView!, attribute: .bottom, multiplier: 1, constant: -10.0)
        let descLabelWidthConstraint = NSLayoutConstraint(item: emptyLabel!, attribute: .width, relatedBy: .equal, toItem: holderView!, attribute: .width, multiplier: 0.9, constant: 0)
        let descLabelCenterXConstraint = NSLayoutConstraint(item: emptyLabel!, attribute: .centerX, relatedBy: .equal, toItem: holderView, attribute: .centerX, multiplier: 1, constant: 0)

        
        let holderSizeFactor:CGFloat = 0.9
        holderView.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = NSLayoutConstraint(item: holderView!, attribute: .centerX, relatedBy: .equal, toItem: emptyView, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: holderView!, attribute: .centerY, relatedBy: .equal, toItem: emptyView, attribute: .centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: holderView!, attribute: .width, relatedBy: .equal, toItem: emptyView!, attribute: .width, multiplier: holderSizeFactor, constant: 0)
        

        emptyView.addConstraints([centerXConstraint, centerYConstraint,widthConstraint])
        holderView.addConstraints([topDescLabelConstraint,bottomDescLabelConstraint,descLabelCenterXConstraint,descLabelWidthConstraint, topLabelConstraint,labelWidthConstraint,labelCenterXConstraint, topImageConstraint, imageCenterXConstraint])

        let imageAspectRatioConstraint = NSLayoutConstraint(item: emptyImageView!, attribute: .width, relatedBy: .equal, toItem: emptyImageView!, attribute: .height, multiplier: 1.0, constant: 0)
        emptyImageView.addConstraints([imageAspectRatioConstraint])
    
    }
    
    func updateEmptyView() {
        
        emptyImageView.image = UIImage.init(named: emptyImageName)
        
    }
    
    
    //MARK:- Actions
    
    @IBAction func refreshData(refreshControl: UIRefreshControl?) {
        
        
    }
    
    @IBAction func showPeriodOptions(_ sender: Any) {
        
        let alert = UIAlertController(title: NSLocalizedString("Pick Period", comment: ""), message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Today", comment: ""), style: UIAlertAction.Style.default, handler: { (action) in
            
            self.selectedPeriod = 1
            self.articlesViewModel.getData(duration: self.selectedPeriod) { (items) in
                self.articlesArray = items as! [NYTArticleElement]
                self.listCollectionView.reloadData()
            }
        }))
            
        alert.addAction(UIAlertAction(title: NSLocalizedString("In a week", comment: ""), style: UIAlertAction.Style.default, handler: { (action) in
            
            self.selectedPeriod = 7
            self.articlesViewModel.getData(duration: self.selectedPeriod) { (items) in
                self.articlesArray = items as! [NYTArticleElement]
                self.listCollectionView.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("In a Month", comment: ""), style: UIAlertAction.Style.default, handler: { (action) in
            
            self.selectedPeriod = 30

            self.articlesViewModel.getData(duration: self.selectedPeriod) { (items) in
                self.articlesArray = items as! [NYTArticleElement]
                self.listCollectionView.reloadData()
            }
        }))
        
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.cancel, handler: { (action) in
            
        }))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let button:UIButton = sender as! UIButton
            
            alert.popoverPresentationController?.sourceView = button.superview
            alert.popoverPresentationController?.sourceRect = button.frame
            alert.popoverPresentationController?.permittedArrowDirections = .any
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }

}

extension ListViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    //MARK:- Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let counts = articlesArray.count;
        if counts == 0 {
            listCollectionView.isHidden = true
            emptyView.isHidden = false
        }
        else {
            listCollectionView.isHidden = false
            emptyView.isHidden = true
        }
        return counts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:ArticleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ARTICLE_CELL", for: indexPath) as! ArticleCollectionViewCell;
        let object = articlesArray[indexPath.item]

        let width = self.view.frame.width
        
        cell.updateView(with: object, width: width)
        
        return cell;
    }
    
    

    //MARK:- Collection View Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let object:NYTArticleElement = articlesArray[indexPath.item]
        articlesViewModel.openArticle(article: object)
    }
    
    //MARK:- Collection View Flow
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                    
        let width = collectionView.frame.width * 0.98
        
        return CGSize(width: width, height: cellHeight);

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
        return spaceInBetweenCell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let edges:UIEdgeInsets = UIEdgeInsets.zero
        return edges
    }
    
}
