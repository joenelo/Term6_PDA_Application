//
//  NearbyCell.swift
//  PDAInClassApp
//
//  Created by joseph nelson on 2018-05-07.
//
import Kingfisher
import UIKit

final class NearbyCell: UICollectionViewCell {
    
    
    // calls the bounds everytime the layout changes *creates circular imageView)
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    @IBOutlet fileprivate var imageView: UIImageView!
    @IBOutlet fileprivate var label: UILabel!
    
    func setData(profile: Profile) {
        self.label.text = profile.username
        
        if let absoluteURL = profile.url, let url = URL(string: absoluteURL){
            self.imageView.kf.setImage(with: url)
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width/2
    }
}
