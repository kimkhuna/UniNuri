//
//  EmailCheckViewController.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/07/01.
//

import UIKit
import Amplify
import AWSCognitoAuthPlugin

class EmailCheckViewController: UIViewController {
    
    var userid: String?
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var codeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.messageTextView.layer.cornerRadius = 10
        self.messageTextView.layer.borderColor = UIColor.black.cgColor
        self.messageTextView.layer.borderWidth = 1

    }
    
    func confirmSignUp(for username: String, with confirmationCode: String) async {
        do {
            let confirmSignUpResult = try await Amplify.Auth.confirmSignUp(
                for: username,
                confirmationCode: confirmationCode
            )
            print("Confirm sign up result completed: \(confirmSignUpResult.isSignUpComplete)")
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmailLoginVC") as? EmailLoginViewController else{return}
            self.present(vc, animated: true)
            
        } catch let error as AuthError {
            print("An error occurred while confirming sign up \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    @IBAction func btnRegisterClicked(_ sender: UIButton) {
        
        if(userid?.isEmpty == true){
            print("Error : Could not load your ID")
            return
        }
        
        if(codeTextField.text?.isEmpty == true){
            print("Error : Please input your Code")
            return
        }
        
        Task{
            await self.confirmSignUp(for: self.userid!, with: self.codeTextField.text!)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
