//
//  SelectLoginViewController.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/06/25.
//

import UIKit
import Amplify
import AWSCognitoAuthPlugin

class SelectLoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var appleBtn: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .orange
        
        self.emailBtn.layer.cornerRadius = 30
        self.emailBtn.layer.borderWidth = 1
        self.emailBtn.layer.borderColor = UIColor.black.cgColor
        
        self.appleBtn.layer.cornerRadius = 30
        self.appleBtn.layer.borderWidth = 1
        self.appleBtn.layer.borderColor = UIColor.black.cgColor
        

        Task{
            await self.fetchCurrentAuthSession()
        }
    }
    
    func fetchCurrentAuthSession() async {
        do {
            let session = try await Amplify.Auth.fetchAuthSession()
            print("Is user signed in - \(session.isSignedIn)")
            
            if(session.isSignedIn == true){
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as? MainViewController else{return}
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
        } catch let error as AuthError {
            print("Fetch session failed with error \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func signOutLocally() async {
        let result = await Amplify.Auth.signOut()
        if let signOutResult = result as? AWSCognitoSignOutResult {
            print("Local signout successful: \(signOutResult.signedOutLocally)")
            switch signOutResult {
            case .complete:
                print("SignOut completed")
            case .failed(let error):
                print("SignOut failed with \(error)")
            case let .partial(revokeTokenError, globalSignOutError, hostedUIError):
                print(
                """
                SignOut is partial.
                RevokeTokenError: \(String(describing: revokeTokenError))
                GlobalSignOutError: \(String(describing: globalSignOutError))
                HostedUIError: \(String(describing: hostedUIError))
                """
                )
            }
        }
    }
    
    @IBAction func btnAppleLoginClicked(_ sender: UIButton) {
        
        Task{
//             await self.socialSignInWithWebUI()
        }

        
    }
    
    func socialSignInWithWebUI() async {
        do {
            let signInResult = try await Amplify.Auth.signInWithWebUI(for: .apple, presentationAnchor: self.view.window!)
            if signInResult.isSignedIn {
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppleRegisterVC") as? AppleRegisterViewController else{return}
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    

}
