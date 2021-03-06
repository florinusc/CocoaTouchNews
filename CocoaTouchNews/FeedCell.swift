//
//  FeedCell.swift
//  CocoaTouchNews
//
//  Created by Florin Uscatu on 11/7/17.
//  Copyright © 2017 Florin Uscatu. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    var item: Item? {
        didSet {
            titleLabel.text = item?.title
            descriptionView.text = item?.summary
        }
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 8.0
    }
    
}
