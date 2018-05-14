//
//  LoginController.swift
//  PDAInClassApp
//
//  Created by joseph nelson on 2018-04-09.
//  Copyright © 2018 joseph nelson. All rights reserved.
//
import UIKit
import Firebase


final class LoginController: UIViewController {

    @IBOutlet fileprivate var usernameField: UITextField!
    @IBOutlet fileprivate var passwordField: UITextField!
    
    @IBAction fileprivate func forgotPasswordTapped(_ sender: UIButton) {
        
    }
    @IBAction fileprivate func loginTapped(_ sender: UIButton) {
        switch sender.tag {
            case 1:
                if let username = usernameField.text,
                    let password = passwordField.text {
                    Auth.auth().signIn(withEmail: username, password:
                    password) { (user, error) in
                        if error == nil {
                            //good
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            // error occured
                            print(error)
                        }
                    }
            }
            case 2:
                return
            case 3:
                return
            default:
                return
        }
    }
    @IBOutlet fileprivate var textView: UITextView!
    @IBAction fileprivate func signupTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignupController", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! SignupController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setTextView()
    }
    
}

fileprivate extension LoginController {
     func setView() {
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
     func setTextView() {
        let text = NSMutableAttributedString(string: "By signing up, you agree to our terms of service & privacy policy")
        let lenght = text.string.count
        let centerStyle = NSMutableParagraphStyle()
        centerStyle.alignment = .center
        text.addAttribute(.paragraphStyle, value: centerStyle, range: NSRange(location: 0, length: lenght))
        text.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: lenght))
        text.addAttribute(.link, value: "https://www.google.ca", range: NSRange(location: 32, length: 16))
        text.addAttribute(.link, value: "https://www.google.ca", range: NSRange(location: 51, length: 14))
        text.addAttribute(.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 32, length: 16))
        text.addAttribute(.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 51, length: 14))
        text.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: lenght))
        self.textView.attributedText = text
    
    }
}
