//
//  PreviewController.swift
//  ClassApp
//
//  Created by joseph nelson on 2018-05-07.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import Foundation
import UIKit
import Firebase
s
final class ProfilePreviewController: UIViewController {
    
    // MARK: IBOutlets.
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var aboutText: UITextView!
    @IBOutlet private var ageText: UITextField!
    @IBOutlet private var halfView: UIView!
    
    // MARK: Properties.
    var profile: Profile?
    
    
    // MARK: Initialization.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the data for the view.
        setData(profile: profile)
        
        // Add padding to textviews.
        aboutText.textContainerInset = UIEdgeInsetsMake(5, 18, 5, 18)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 5))
        ageText.leftView = paddingView
        ageText.leftViewMode = .always
    }
    
    override func viewDidLayoutSubviews() {
        // Round corners of imageview.
        icon.layer.cornerRadius = icon.frame.width/2
        
        // Set halfview height
        halfView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: icon.frame.maxY/2+30)
    }
    

    func setData(profile: Profile?) {
        guard let profile = profile else {return}
        
        self.title = profile.username
        self.aboutText.text = profile.about
        self.ageText.text = profile.age
        
        
        if aboutText.text == "" {
            self.aboutText.text = "This is some information about me and yada yada yada"
        }
        if ageText.text == "" {
            self.ageText.text = "29"
        }

        // Image.
        if let absoluteUrl = profile.url, let url = URL(string: absoluteUrl) {
            self.icon.kf.setImage(with: url)
        }
    }
}


