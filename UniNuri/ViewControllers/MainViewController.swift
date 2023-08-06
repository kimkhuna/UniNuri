//
//  MainViewController.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/06/10.
//

import UIKit
import Amplify
import AWSAPIPlugin
import AWSDataStorePlugin

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var freeTableView: UITableView!
    @IBOutlet weak var infoTableView: UITableView!
    
    var freeboard: [Freeboard] = []
    var infoboard: [Infoboard] = []
 
    var userName: String?
    
    @IBOutlet weak var communityView: UIStackView!    
    @IBOutlet weak var infomationView: UIStackView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.navigationBar.tintColor = .orange
        
        
        UserDefaults.standard.setValue(UUID().uuidString, forKey: "UUID")
        
        
        Task{
            freeTableView.dataSource = self
            freeTableView.delegate = self
            await self.getFreeboard()
        }
        
        Task{
            infoTableView.dataSource = self
            infoTableView.delegate = self
            await self.getInfoboard()
        }
        
        communityView.layer.borderWidth = 1.5
        communityView.layer.cornerRadius = 10
        communityView.layer.borderColor = UIColor.black.cgColor
        
        infomationView.layer.borderWidth = 1.5
        infomationView.layer.cornerRadius = 10
        infomationView.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    func readFreeboard() async -> [Freeboard]{
        do {
            let frees = try await Amplify.DataStore.query(Freeboard.self)
            
            return frees
            
        } catch let error as DataStoreError {
            print("Error retrieving posts \(error)")
        } catch {
            print("Unexpected error \(error)")
        }
        
        return []
    }
    
    func getFreeboard() async{
        do{
            let freeData = try await readFreeboard()
            freeboard = freeData
            freeTableView.reloadData()
        }
        catch let e{
            print("Failed to get Freeboard Data : \(e.localizedDescription)")
        }
    }
    
    func readInfoboard() async -> [Infoboard]{
        do{
            let infos = try await Amplify.DataStore.query(Infoboard.self)
            return infos
        }
        catch let error as DataStoreError {
            print("Error retrieving posts \(error)")
        }catch {
            print("Unexpected error \(error)")
        }
        return []
    }
    
    func getInfoboard() async{
        do{
            let infoData = try await readInfoboard()
            infoboard = infoData
            infoTableView.reloadData()
        }
        catch let e{
            print("Failed to get Infoboard : \(e.localizedDescription)")
        }
    }

}

// TableView Setting
extension MainViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if tableView == freeTableView {
            return freeboard.count
            
        }
        else if tableView == infoTableView{
            
            return infoboard.count
        }
        
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
       
        
        if tableView == infoTableView {
            
            guard let infoCell = infoTableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoTableViewCell else{return UITableViewCell()}
            
            infoCell.titleLabel.text = infoboard[indexPath.row].title
            infoCell.writerLabel.text = infoboard[indexPath.row].writer

            return infoCell
        }
        
        if(tableView == freeTableView){
            
            guard let freeCell = freeTableView.dequeueReusableCell(withIdentifier: "freeCell", for: indexPath) as? FreeTableViewCell else{return UITableViewCell()}
            freeCell.titleLabel.text = freeboard[indexPath.row].title
            freeCell.writerLabel.text = freeboard[indexPath.row].writer
            return freeCell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    

}
