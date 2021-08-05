//
//  ItemContentCell.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 04/08/21.
//

import UIKit

class ItemContentCell: UICollectionViewCell {
    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var counterLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var shotInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initItem(content: ContentEntity){
        self.setRoundedCorner()
        counterLabel.text = "\(content.score!)"
        shotInfoLabel.text = "\(content.num_comments!)"
        contentLabel.text = content.title
        coverImage.image = content.image
    }
}
