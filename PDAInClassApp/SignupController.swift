//
//  SignupController.swift
//  PDAInClassApp
//
//  Created by joseph nelson on 2018-04-16.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import Firebase

final class SignupController: UIViewController {
    
    let model = SignupModel()
    
    
    //MARK: IBOutlets
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet fileprivate var fields: [UITextField]!
    @IBOutlet fileprivate weak var photoButton: UIButton!
    
    //MARK: IBActions
    @IBAction fileprivate func signupTapped(_ sender: UIButton) {
        indicator.startAnimating()
        sender.isEnabled = false
        // make a dictionary for data
        var data = [String: String]()
        if let username = fields[0].text {
            data["username"] = username
        }
        if let email = fields[1].text {
            data["email"] = email
        }
        if let password = fields[2].text {
            data["password"] = password
        }
        if let repeatPassword = fields[3].text {
            data["repeatPassword"] = repeatPassword
        }
        
        if model.validate(data: data) {
            model.authenticate(data: data, completion: { (error) in
                self.indicator.stopAnimating()
                sender.isEnabled = true
                guard error == nil else {
                    // bad - error
                    let alert = self.model.makeAlert(message: "Failed to signup")
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                // good - no error
                self.dismiss(animated: true, completion: nil)
                
            })
        } else  {
            indicator.stopAnimating()
            sender.isEnabled = true
            let alert = self.model.makeAlert(message: "Invalid Input")
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction fileprivate func dismissedTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction fileprivate func photoTapped(_ sender: UIButton) {
        media(sourceType: .photoLibrary)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
}

extension SignupController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            photoButton.setBackgroundImage(image, for: .normal)
            model.photo = image
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func media(sourceType: UIImagePickerControllerSourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        parent?.present(picker, animated: true, completion: nil)
    }
}


extension SignupController {
    fileprivate func setView() {
        let gradient = CAGradientLayer()
        let color1 = UIColor(hexadecimal: 0xFFB4B4)
        let color2 = UIColor(hexadecimal: 0x867AC7)
        let colors: [CGColor] = [color1.cgColor, color2.cgColor]
        let start = CGPoint(x: 0, y: 0)
        let end = CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height)
        gradient.startPoint = start
        gradient.endPoint = end
        gradient.colors = colors
        gradient.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
        self.view.layer.insertSublayer(gradient,at: 0)
    }
}
