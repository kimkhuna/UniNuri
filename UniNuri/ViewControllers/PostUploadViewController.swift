//
//  PostUploadViewController.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/07/02.
//

import UIKit
import DropDown
import Amplify
import AWSDataStorePlugin

class PostUploadViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var categorySearchBtn: UIButton!
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    @IBOutlet weak var categoryView: UIView!
    
    var category: String?
    
    let dropDown = DropDown()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryTextField.text = category ?? ""
        
        
        dropDown.anchorView = categoryView

        dropDown.dataSource = ["FreeBoard", "InfoBoard"]
        
    }
    @IBAction func btncategoryClicked(_ sender: UIButton) {
        
        dropDown.show()

        dropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.categoryTextField.text! = item
        }
    }
    
    @IBAction func btnUploadClicked(_ sender: UIButton) {

        if(category == "InfoBoard"){
            Task{
                await self.uploadInfoBoard()
            }
        }
        else if(category == "FreeBoard"){
            Task{
                
            }
        }
    }
    
    func uploadInfoBoard() async{
        let uuid = UserDefaults.standard.string(forKey: "UUID")
        let name = UserDefaults.standard.string(forKey: "UserName")
        
        let post = Infoboard(title: self.titleTextField.text!, content: self.contentTextView.text!, writer: name!)
        do {
            try await Amplify.DataStore.save(post)
            print("Post saved successfully!")
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoVC") as? InfoViewController else{return}
            self.navigationController?.pushViewController(vc, animated: true)
        } catch let error as DataStoreError {
            print("Error saving post \(error)")
        } catch {
            print("Unexpected error \(error)")
        }
     }
    
    func uploadFreeBoard() async{
        let uuid = UserDefaults.standard.string(forKey: "UUID")
        let name = UserDefaults.standard.string(forKey: "UserName")
        
        let post = Freeboard(title: self.titleTextField.text!, content: self.contentTextView.text!, writer: name!)
        do {
            try await Amplify.DataStore.save(post)
            print("Post saved successfully!")
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "FreeVC") as? FreeViewController else{return}
            self.navigationController?.pushViewController(vc, animated: true)
        } catch let error as DataStoreError {
            print("Error saving post \(error)")
        } catch {
            print("Unexpected error \(error)")
        }
     }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

}
