//
//  ArticleCollectionViewCell.swift
//  NYT
//
//  Created by heba on 10/28/19.
//  Copyright © 2020 Heba. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var icon: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateValueLabel: UILabel!

    var articleObject:NYTArticleElement?

    func updateView(with object: NYTArticleElement, width: CGFloat) {

        articleObject = object
        
        self.backgroundColor = UIColor.NYTBGColor()
        self.contentView.backgroundColor = UIColor.NYTBGColor()
        
        self.updateTitleLabel(width: width)
        self.updateAuthorLabel(width: width)
        self.updateDateLabel(width: width)
        self.updateImage()
    }
    
    func updateTitleLabel(width:CGFloat) {
           
        let text = ArticleViewModel.getArticleTitle(article: articleObject)
        let fontSize=14.0 * width * UIFont.getFontFactor()
        
        let labelAttrs = [NSAttributedString.Key.font : UIFont.NYTBoldFont().withSize(fontSize), NSAttributedString.Key.foregroundColor: UIColor.black]
        titleLabel.attributedText=NSAttributedString(string:  text, attributes: labelAttrs)
    }

    func updateAuthorLabel(width:CGFloat) {
        
        let text = ArticleViewModel.getAuthorValue(article: articleObject)
        let fontSize=12.0 * width * UIFont.getFontFactor()
        
        let labelAttrs = [NSAttributedString.Key.font : UIFont.NYTRegularFont().withSize(fontSize), NSAttributedString.Key.foregroundColor: UIColor.gray]
        authorLabel.attributedText=NSAttributedString(string:  text, attributes: labelAttrs)
    }
    
    func updateDateLabel(width:CGFloat) {
        
        let text = ArticleViewModel.getDateValue(article: articleObject)
        let fontSize=12.0 * width * UIFont.getFontFactor()
            
        let labelAttrs = [NSAttributedString.Key.font : UIFont.NYTRegularFont().withSize(fontSize), NSAttributedString.Key.foregroundColor: UIColor.gray]
        dateValueLabel.attributedText=NSAttributedString(string:  text, attributes: labelAttrs)
    }
    
    func updateImage() {
        
        let imageURL = ArticleViewModel.getArticleImageURL(article: articleObject)
            
        if imageURL != "" {
            
            icon?.sd_setImage(with: URL.init(string: imageURL), placeholderImage: .init(imageLiteralResourceName: "Logo"), options: []) { (image, error, type, url) in
                
            }
        }
        else {
            icon.image = .init(imageLiteralResourceName: "Logo")
        }
        
        icon.layer.cornerRadius = icon.frame.size.height * 0.5;

    }

}
