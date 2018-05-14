//
//  SignupModel.swift
//  PDAInClassApp
//
//  Created by joseph nelson on 2018-04-23.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import Firebase

final class SignupModel {
    var photo: UIImage?
    
    func validate(data: [String: String]) -> Bool {

        guard
            let username = data["username"],
            let email = data["email"],
            let password = data["password"],
            let repeatPassword = data["repeatPassword"]
            else { return false }
        
        if password != repeatPassword {
            return false
        }
        if password.count < 8 {
            return false
        }
        if username.count < 3 {
            return false
        }
        if email.count < 3 {
            return false
        }
        return true
    }
    
    // --- Authenticate user --- //
    func authenticate (data: [String: String], completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: data["email"]!, password: data["password"]!, completion:  { (user, error) in
            guard error == nil, let user = user else {
                // not good
                completion(error)
                return
            }
            var object: [String: String] = [:]
            object["email"] = data["email"]
            object["username"] = data["username"]
            Database.database()
                .reference()
                .child("Users")
                .child(user.uid)
                .setValue(object, withCompletionBlock: { (error, reference) in
                guard error == nil else {
                    completion(error)
                    // not good, error
                    Auth.auth().currentUser?.delete(completion:{ (error) in
                    completion(error)
                })
                    return
                }
                // good
                if let photo = self.photo {
                    let photoData = UIImageJPEGRepresentation(photo, 0.7)
                    
                    Storage.storage().reference().child("Users").child(user.uid).putData(photoData!, metadata: nil, completion: { (metadata, error) in
                        guard error == nil, let url = metadata?.downloadURL()?.absoluteString  else {
                            return
                        }
                        // no error
                        Database.database().reference().child("Users").child(user.uid).updateChildValues(["url":url])
                    })
                }
                completion(nil)
            })
            
        })
    }
    
    func makeAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okay)
        return alert
    }
}
