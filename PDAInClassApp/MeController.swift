//
//  MeController.swift
//  PDAInClassApp
//
//  Created by joseph nelson on 2018-05-07.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import Firebase

final class MeController: UIViewController {
    
    fileprivate var profile: Profile?
    
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameField: UITextField!
    @IBOutlet private var aboutTextView: UITextView!
    @IBOutlet private var ageField: UITextField!
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
            sender.isEnabled = true
        }
        
        guard let name = nameField.text,
                let age = ageField.text,
                let about = aboutTextView.text,
            let UID = Auth.auth().currentUser?.uid else {
                return
        }
        
        var object = [String: String]()
        object["username"] = name
        object["age"] = age
        object["about"] = about
        
        Database.database().reference().child("Users").child(UID).updateChildValues(object)
        
        if let image = self.profileImageView.image {
            let data = UIImagePNGRepresentation(image)!
            Storage.storage().reference()
                    .child("Users")
                    .child(UID)
                .putData(data, metadata: nil) { (metaData, error) in
                    guard let absolute = metaData?.downloadURL()?.absoluteString else{
                        return
            }
            Database.database().reference()
                    .child("Users")
                    .child(UID)
                .updateChildValues(["url":absolute])
                    
                    }
        }
    }
    @objc func imageViewTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileImageView()
        setFields()
        load()
    }
}

fileprivate extension MeController {
    func load() {
        if let UID = Auth.auth().currentUser?.uid {
            Database.database().reference()
            .child("Users")
            .child(UID)
                .observeSingleEvent(of: .value) { snapshot in
                    let profile = Profile(snapshot: snapshot)
                    self.profile = profile
                    print(profile)
                    self.ageField.text = profile?.age ?? ""
                    self.aboutTextView.text = profile?.about ?? ""
                    self.nameField.text = profile?.username ?? ""

                    
            }
        }
    }
}


fileprivate extension MeController {
    func setupProfileImageView() {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(imageViewTapped))
        profileImageView.addGestureRecognizer(recognizer)
    }
    
    // function to se the fields to contain nothing
    func setFields() {
        self.nameField.text = ""
        self.ageField.text = ""
        self.aboutTextView.text = ""
    }
}

extension MeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
