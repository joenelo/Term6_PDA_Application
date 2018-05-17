//
//  PostFeedController.swift
//  PDAInClassApp
//
//  Created by joseph nelson on 2018-05-16.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import Firebase

final class PostFeedController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var imageButton: UIButton!
    
    //MARK: IB Actions
    @IBAction private func imageButtonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction private func postTapped(_ sender: UIBarButtonItem) {
        
        guard
            let image = self.imageButton.backgroundImage(for: .normal),
            let data = UIImageJPEGRepresentation(image, 0.6) else {
                return
        }
        let uuid = UUID().uuidString
        Storage.storage().reference()
            .child("Posts")
            .child(uuid)
            .putData(data, metadata: nil) { [weak self] (metadata, error) in
                let url = metadata!.downloadURL()!.absoluteString
                var object = [String: String]()
                object["url"] = url
                object["title"] = self!.textView.text!
                Database.database().reference()
                    .child("Posts")
                    .child(uuid)
                    .setValue(object, withCompletionBlock: { (error, reference) in
                        self?.navigationController?.popViewController(animated: true)
                })
                
        }
    }
}

extension PostFeedController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageButton.setBackgroundImage(image, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}
