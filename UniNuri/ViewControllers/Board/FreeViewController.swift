//
//  FreeViewController.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/06/17.
//

import UIKit
import Amplify
import AWSAPIPlugin
import AWSDataStorePlugin


class FreeViewController: UIViewController {
    
    
    //7c321c46-00cc-43ee-8fc6-efad902f6511
    @IBOutlet weak var tableView: UITableView!
    
    var freeboard: [Freeboard] = []
    var freecomment: [Freecomment] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        
        let nibName = UINib(nibName: "FreeDetailTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "FreeDetailCell")
        
        Task{
            
            tableView.dataSource = self
            tableView.delegate = self
            
            await self.getFreeboard()
        }
        
        
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
            tableView.reloadData()
        }
        catch let e{
            print("Failed to get Freeboard Data : \(e.localizedDescription)")
        }
    }
    
    @IBAction func btnUploadClicked(_ sender: UIBarButtonItem) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadVC") as? PostUploadViewController else{return}
        vc.category = "FreeBoard"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    

}

extension FreeViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FreeDetailCell", for: indexPath) as? FreeDetailTableViewCell else {return UITableViewCell()}
        
        let temperalDateFormatter = TemporalFormat.short
        cell.titleLabel.text = freeboard[indexPath.row].title
        cell.contentLabel.text = freeboard[indexPath.row].content
        cell.writerLabel.text = freeboard[indexPath.row].writer
        cell.dateLabel.text = freeboard[indexPath.row].registerdate?.iso8601FormattedString(format: temperalDateFormatter)
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return freeboard.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PostDetailVC") as? PostDetailViewController else{return}
        
        let temperalDateFormatter = TemporalFormat.short
        
        vc.category = "Freeboard"
        vc.boardID = freeboard[indexPath.row].id
        vc.postTitle = freeboard[indexPath.row].title
        vc.content = freeboard[indexPath.row].content
        vc.writer = freeboard[indexPath.row].writer
        vc.date = freeboard[indexPath.row].registerdate?.iso8601FormattedString(format: temperalDateFormatter)
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
