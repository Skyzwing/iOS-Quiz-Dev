//
//  tagCollectionViewCell.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 22/10/23.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagBackgroundView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        tagBackgroundView.layer.cornerRadius = 8
        tagBackgroundView.layer.borderWidth = 2
        tagBackgroundView.layer.borderColor = UIColor.systemGray6.cgColor
    }
}
