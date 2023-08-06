//
//  EmailRegisterViewController.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/06/25.
//

import UIKit
import Amplify
import AWSCognitoAuthPlugin
import DropDown
import AWSDataStorePlugin

class EmailRegisterViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var isValidEmailLabel: UILabel!
    @IBOutlet weak var isValidPasswordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var isCorrectPasswordLabel: UILabel!
    @IBOutlet weak var countryView: UIStackView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var univLabel: UILabel!
    
    @IBOutlet weak var yearView: UIStackView!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    let countryDropdown = DropDown()
    let yearDropDown = DropDown()
    
    var university = String()
    var tempCountry = String()
    var year = String()
    
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DropDown
        countryDropdown.anchorView = countryView
        countryDropdown.dataSource = ["Korea, Republic of", "Japan", "United State", "Spain"]
        
        yearDropDown.anchorView = yearView
        yearDropDown.dataSource = ["2023", "2022", "2021", "2020", "2019", "2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011", "2010"]
        
        self.univLabel.text = university
        self.countryLabel.text = tempCountry
        self.yearLabel.text = year
        
        // Email, 비밀번호 형식 확인
        emailTextField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(textFieldCompare), for: .editingChanged)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    
    //MARK: IBActions
    @IBAction func btnCountryClicked(_ sender: UIButton) {
        countryDropdown.show()
        countryDropdown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.countryLabel.text = item
        }
    }
    
    @IBAction func btnUnivClicked(_ sender: UIButton) {
        
        let selectCountry = self.countryLabel.text
        
        if(selectCountry?.isEmpty == true){
            print("Please select country")
            return
        }

        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "UnivListVC") as? UnivListViewController else{return}
        
        // URL Encoding시 공백 %20 또는 + 로 처리
                if(selectCountry == "Korea, Republic of"){
                    vc.country = "Korea, Republic of"
                }
                else if(selectCountry == "United State"){
                    vc.country = "United%20State"
                }
                else{
        vc.country = selectCountry!
                }
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnYearClicked(_ sender: UIButton) {
        
        yearDropDown.show()
        yearDropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.yearLabel.text = item
        }
    }
    
    
    
    
    @IBAction func btnRegisterClicked(_ sender: UIButton) {
        
        
        if(self.emailTextField.text?.isEmpty == true){
            let alertController = UIAlertController(title: "Error", message: "Please input Email address", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }
        else if(self.passwordTextField.text?.isEmpty == true){
            let alertController = UIAlertController(title: "Error", message: "Please input Password address", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }
        
        Task{
            await self.signUp(username: self.idTextField.text!, password: self.passwordTextField.text!, email: self.emailTextField.text!)
        }
    }
    
    //MARK: SignUp
    func signUp(username: String, password: String, email: String) async {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        do {
            let signUpResult = try await Amplify.Auth.signUp(
                username: username,
                password: password,
                options: options
            )
            if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
                print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId)))")
            } else {
                print("SignUp Complete")
            }
            
            await self.uploadUserInfo()
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmailCheckVC") as? EmailCheckViewController else{return}
            vc.userid = self.emailTextField.text!
            self.navigationController?.pushViewController(vc, animated: true)
        } catch let error as AuthError {
            print("An error occurred while registering a user \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func uploadUserInfo() async{
        
        let nickname = self.idTextField.text
        let country = self.countryLabel.text
        let school = self.univLabel.text
        let enterance_year = self.yearLabel.text
        
        let userInfo = UserInfo(nickname: nickname!, country: country!, school: school!, entrance_year: enterance_year!)
        
        do{
            try await Amplify.DataStore.save(userInfo)
            print("UserInfo saved successfully !")
        }
        catch let error as DataStoreError{
            print("Error saving UserInfo : \(error.errorDescription)")
            return
        }
        catch{
            print("Unexpected error \(error)")
            return
        }
        
    }

    
    // Confirm Email, Password
    @objc func textFieldEdited(textField: UITextField){
        
        if textField == emailTextField{
            if emailTextField.text?.isEmpty == false{
                if isValidEmail(email: textField.text) == true{
                    isValidEmailLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
                }
                else{
                    isValidEmailLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
                    isValidEmailLabel.text = "The email format is not valid."
                    isValidEmailLabel.textColor = .red
                }
            }
            else{
                isValidEmailLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
            }
        }
        
        else if textField == passwordTextField{
            
            
            if isValidPassword(pw: textField.text) == true{
                isValidPasswordLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
            }
            else{
                isValidPasswordLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
                isValidPasswordLabel.text = "The password format is not valid."
                isValidPasswordLabel.textColor = .red
            }
        }
    }
    
    @objc func textFieldCompare(textField: UITextField){
        if textField == confirmPasswordTextField{
            
            if isSamePassword(pw: passwordTextField.text, checkpw: confirmPasswordTextField.text) == true{
                isCorrectPasswordLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
                isCorrectPasswordLabel.text = "Password is correct"
                isCorrectPasswordLabel.textColor = .green
            }
            else{
                isCorrectPasswordLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
            }
        }
    }
    
    
    // MARK: Regular Expression
    
    // Email Regular expression
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else {return false}
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        return pred.evaluate(with: email)
    }
    
    // Password Regular expression
    func isValidPassword(pw: String?) -> Bool {
        
        guard pw != nil else {return false}
        
        let regEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        return pred.evaluate(with: pw)
    }
    
    // Compare Password
    func isSamePassword(pw: String?, checkpw: String?) -> Bool{
        
        let pw = passwordTextField.text
        let checkpw = confirmPasswordTextField.text
        
        if pw == checkpw{
            return true
        }else{
            return false
        }
    }
}
