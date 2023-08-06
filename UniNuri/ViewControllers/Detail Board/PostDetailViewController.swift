//
//  PostDetailViewController.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/06/19.
//

import UIKit
import Amplify
import AWSAPIPlugin
import AWSDataStorePlugin

class PostDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var commentView: UIView!
    
    
    var category: String?
    var boardID: String?
    var postTitle: String?
    var writer: String?
    var date: String?
    var content: String?
    
    var freeComment: [Freecomment] = []
    var infoComment: [Infocomment] = []
    
    var thisFreeComment: [Freecomment] = []
    var thisInfoComment: [Infocomment] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.titleLabel.text = postTitle
        self.writerLabel.text = writer
        self.contentTextView.text = content
        self.dateLabel.text = date
        
        let nibName = UINib(nibName: "CommentTableViewCell", bundle: nil)
        commentTableView.register(nibName, forCellReuseIdentifier: "CommentCell")
        
        
//        contentTextView.layer.borderWidth = 1.5
//        contentTextView.layer.cornerRadius = 10
//        contentTextView.layer.borderColor = UIColor.black.cgColor
        
        commentView.layer.borderWidth = 1.5
        commentView.layer.cornerRadius = 10
        commentView.layer.borderColor = UIColor.black.cgColor
        
        
        Task{
            
            commentTableView.delegate = self
            commentTableView.dataSource = self
            
            if(category == "Freeboard"){
                await getFreecomment()
                
                for i in 0..<freeComment.count{
                    if(freeComment[i].freeboardID == boardID){
                        thisFreeComment.append(freeComment[i])
                        print(thisFreeComment)
                    }
                }
            }
            else if(category == "Infoboard"){
                await getInfocomment()
                
                for i in 0..<infoComment.count{
                    if(infoComment[i].infoboardID == boardID){
                        thisInfoComment.append(infoComment[i])
                        print(thisInfoComment)
                    }
                }
                        
            }
            else{
                print("category is not found..")
            }
            
            
        }
        
        
    }
    
    func readFreeBoardComment() async -> [Freecomment]{
        do{
            let freecomments = try await Amplify.DataStore.query(Freecomment.self)
            
            return freecomments
        }
        catch let error as DataStoreError{
            print("Error retrieving posts \(error)")
        }
        catch{
            print("err")
        }
        
        return []
    }
    
    func getFreecomment() async{
        do{
            let freeData = try await readFreeBoardComment()
            freeComment = freeData
            
        }
        catch let e{
            print("Failed to get Freeboard Data : \(e.localizedDescription)")
        }
    }
    
    func readInfoBoardComment() async -> [Infocomment]{
        do{
            let infocomments = try await Amplify.DataStore.query(Infocomment.self)
            
            return infocomments
        }
        catch let error as DataStoreError{
            print("Error retrieving posts \(error)")
        }
        catch{
            print("err")
        }
        
        return []
    }
    
    func getInfocomment() async{
        do{
            let infoData = try await readInfoBoardComment()
            infoComment = infoData
            
        }
        catch let e{
            print("Failed to get Freeboard Data : \(e.localizedDescription)")
        }
    }
}


extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(category == "Infoboard"){
            return thisInfoComment.count
        }
        else if(category == "Freeboard"){
            return thisFreeComment.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = commentTableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentTableViewCell else{return UITableViewCell()}
        
        cell.layer.borderWidth = 0.7
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.black.cgColor
        
        
        if(category == "Infoboard"){
            cell.writerLabel.text = thisInfoComment[indexPath.row].com_writer
            cell.commentLabel.text = thisInfoComment[indexPath.row].com_content
            cell.dateLabel.text = thisInfoComment[indexPath.row].createdAt?.iso8601String
            
            return cell
        }
        else if(category == "Freeboard"){
            cell.writerLabel.text = thisFreeComment[indexPath.row].com_writer
            cell.commentLabel.text = thisFreeComment[indexPath.row].com_content
            cell.dateLabel.text = thisFreeComment[indexPath.row].createdAt?.iso8601String
            
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    
}
