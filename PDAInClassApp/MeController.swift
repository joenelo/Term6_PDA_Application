

import Foundation
import UIKit
import Firebase

final class MeController: UIViewController {
    
    fileprivate var profile: Profile?
    
    // MARK: IBOutlets.
    
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameField: UITextField!
    @IBOutlet private var aboutTextView: UITextView!
    @IBOutlet private var ageField: UITextField!
    @IBOutlet private var indicator: UIActivityIndicatorView!
    @IBOutlet private var overlay: UIView!
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        showOverlay()
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) {[weak self] timer in
            self?.hideOverlay()
        }
        
        
        
        guard let name = nameField.text, let age = ageField.text, let about = aboutTextView.text, let UID = Auth.auth().currentUser?.uid else { return }
        
        var object = [String: String]()
        object["username"] = name
        object["age"] = age
        object["about"] = about
        
        Database.database().reference().child("Users").child(UID).updateChildValues(object)
        
        if let image = self.profileImageView.image {
            let data = UIImageJPEGRepresentation(image, 0.6)!
            Storage.storage().reference()
                .child("Users")
                .child(UID)
                .putData(data, metadata: nil) {(metaData, error) in
                    guard let absolute = metaData?.downloadURL()?.absoluteString else { return }
                    
                    Database.database().reference().child("Users").child(UID).updateChildValues(["url":absolute])
            }
        }
        
    }
    
    
    
    // MARK: Initialization.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set views.
        setupProfileImageView()
        setFields()
        setOverlay()
        loadData()
        loadPhoto()
        showOverlay()
    }
    
    private func showOverlay() {
        self.indicator.startAnimating()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.overlay.alpha = 1
        }
        
    }
    private func hideOverlay() {
        indicator.stopAnimating()
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.overlay.alpha = 0
        }
    }
    
    @objc func imageViewTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
    
}


fileprivate extension MeController {
    func loadData() {
        if let UID = Auth.auth().currentUser?.uid {
            Database.database().reference()
                .child("Users")
                .child(UID)
                .observeSingleEvent(of: .value) {[weak self] snapshot in
                    let profile = Profile(snapshot: snapshot)
                    self?.profile = profile
                    
                    self?.nameField.text = profile?.username ?? ""
                    self?.aboutTextView.text = profile?.about ?? ""
                    self?.ageField.text = profile?.age ?? ""
    
            }
        }
    }
    
    func loadPhoto() {
        guard let UID = Auth.auth().currentUser?.uid  else {return}
        
        Storage.storage().reference()
            .child("Users")
            .child(UID)
            .getData(maxSize: 2024*1000) { [weak self] (data, error) in
                
                self?.hideOverlay()
                guard let data = data else {return}
                self?.profileImageView.image = UIImage(data: data)
        }
    }
}

fileprivate extension MeController {
    func setupProfileImageView() {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(self.imageViewTapped))
        profileImageView.addGestureRecognizer(recognizer)
    }
    
    func setFields() {
        self.nameField.text = ""
        self.ageField.text = ""
        self.aboutTextView.text = ""
    }
    
    func setOverlay() {
        self.view.addSubview(overlay)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        overlay.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        overlay.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        overlay.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        overlay.alpha = 0
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
