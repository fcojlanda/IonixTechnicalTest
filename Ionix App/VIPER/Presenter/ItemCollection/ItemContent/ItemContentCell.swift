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
    @IBOutlet var loaderActivity: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initItem(content: ContentEntity){
        self.setRoundedCorner()
        counterLabel.text = "\(content.score!)"
        shotInfoLabel.text = "\(content.num_comments!)"
        contentLabel.text = content.title
        coverImage.image = content.memeImage
        coverImage.contentMode = .scaleAspectFill
        loaderActivity.startAnimating()
        loaderActivity.isHidden = false
        coverImage.downloadImage(url: content.urlImage!, loaded: { (status) in
            DispatchQueue.main.async {
                self.coverImage.contentMode = .scaleAspectFit
                self.loaderActivity.stopAnimating()
                self.loaderActivity.isHidden = true
            }
        })
    }
}
