//
//  InfoViewController.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/06/17.
//

import UIKit
import Amplify
import AWSAPIPlugin
import AWSDataStorePlugin

class InfoViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var infoboard: [Infoboard] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        let nibName = UINib(nibName: "InfoDetailTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "InfoDetailCell")
        
        Task{
            
            tableView.dataSource = self
            tableView.delegate = self
            
            await self.getInfoboard()
    
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
            tableView.reloadData()
        }
        catch let e{
            print("Failed to get Infoboard : \(e.localizedDescription)")
        }
    }

    @IBAction func btnUploadClicked(_ sender: UIBarButtonItem) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadVC") as? PostUploadViewController else{return}
        vc.category = "InfoBoard"
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}


extension InfoViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetailCell", for: indexPath) as? InfoDetailTableViewCell else{return UITableViewCell()}
        cell.titleLabel.text = infoboard[indexPath.row].title
        cell.writerLabel.text = infoboard[indexPath.row].writer
        cell.contentLabel.text = infoboard[indexPath.row].content
//        cell.dateLabel.text = infoboard[indexPath.row].registerdate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoboard.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PostDetailVC") as? PostDetailViewController else{return}
        
        vc.category = "Infoboard"
        vc.boardID = infoboard[indexPath.row].id
        vc.postTitle = infoboard[indexPath.row].title
        vc.content = infoboard[indexPath.row].content
        vc.writer = infoboard[indexPath.row].writer
        vc.date = infoboard[indexPath.row].registerdate?.iso8601String
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
