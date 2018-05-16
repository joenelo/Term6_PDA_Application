//
//  FeedPhotoCell.swift
//  PDAInClassApp
//
//  Created by joseph nelson on 2018-05-16.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import Kingfisher

final class FeedPhotoCell: UITableViewCell {
    @IBOutlet var feedImageView:UIImageView!
    @IBOutlet var label:UILabel!

    func setData(photo: PhotoFeed) {
        feedImageView.kf.setImage(with: URL(string: photo.url))
        label.text = photo.title
    }
}
