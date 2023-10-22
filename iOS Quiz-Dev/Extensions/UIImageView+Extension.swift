//
//  UIImageView.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 21/10/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with url: URL, placeholder: UIImage? = nil) {
        self.kf.setImage(with: url, placeholder: placeholder)
    }
}
