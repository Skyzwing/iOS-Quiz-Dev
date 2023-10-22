//
//  CollectionViewCell.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 22/10/23.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        bannerImageView.layer.cornerRadius = 16
    }
    
    func configImage(image: String?) {
        if let imageString = image, let url = URL(string: imageString) {
            bannerImageView.setImage(with: url)
        } else {
            bannerImageView.image = UIImage(named: "placeholder")
        }
    }

}
