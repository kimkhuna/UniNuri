//
//  EmailLoginViewController.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/06/25.
//

import UIKit
import Amplify
import AWSCognitoAuthPlugin

class EmailLoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var changePasswordBtn: UIButton!
    
    @IBOutlet weak var subBtnStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.loginBtn.layer.cornerRadius = 10
        self.loginBtn.layer.borderWidth = 1
        self.loginBtn.layer.borderColor = UIColor.black.cgColor
        
        self.registerBtn.layer.cornerRadius = 10
        self.registerBtn.layer.borderWidth = 1
        self.registerBtn.layer.borderColor = UIColor.black.cgColor
        
        self.changePasswordBtn.layer.cornerRadius = 10
        self.changePasswordBtn.layer.borderWidth = 1
        self.changePasswordBtn.layer.borderColor = UIColor.black.cgColor

        
        
        


    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        
        if(self.emailTextField.text?.isEmpty == true){
            let alertController = UIAlertController(title: "Error", message: "Please input email address", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
            return
        }
        else if(self.emailTextField.text?.isEmpty == true){
            let alertController = UIAlertController(title: "Error", message: "Please input password address", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
            return
        }
        
        Task{
            await self.signIn(username: self.emailTextField.text!, password:self.passwordTextField.text!)
        }
    }
    
    
    func signIn(username: String, password: String) async {
        do {
            let signInResult = try await Amplify.Auth.signIn(
                username: username,
                password: password
                )
            if signInResult.isSignedIn {
                print("Sign in succeeded")
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as? MainViewController else{return}
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }

}
