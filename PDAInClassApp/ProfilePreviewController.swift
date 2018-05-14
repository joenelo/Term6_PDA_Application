//
//  ProfilePreviewController.swift
//  PDAInClassApp
//
//  Created by joseph nelson on 2018-05-07.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit

final class ProfilePreviewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var aboutText: UITextView!
    @IBOutlet weak var ageText: UITextField!
    
    //: MARK Profile Properties
    var profileData: Profile?
    
    // MARK: Initialization.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set data for the view.
        guard let profileData = profileData else {return}
        setProfileData(profileData: profileData)
        viewDidLayoutSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        // Make Imageview a Circle
        profileImage.layer.cornerRadius = profileImage.frame.width/2
    }
    
    func setProfileData (profileData: Profile) {
        
        // Set the title to the name of the username from the profile and the other
        // Field Data from the profile.swift file
        
        self.title = profileData.username
        
        self.aboutText.text = profileData.about
        
        self.ageText.text = profileData.age
        
        
        guard let imageUrl = profileData.url, let url = URL(string: imageUrl) else {return}
            self.profileImage.kf.setImage(with: url)
        }
}
