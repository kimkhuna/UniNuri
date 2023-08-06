//
//  UnivListViewController.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/07/07.
//

import UIKit
import Alamofire

class UnivListViewController: UIViewController {

    var country = String()
    var allUniv: [Univ] = []
    var filterUniv: [Univ] = []
    
    @IBOutlet weak var listTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchController()
        
        let nibName = UINib(nibName: "UnivTableViewCell", bundle: nil)
        listTableView.register(nibName, forCellReuseIdentifier: "UnivCell")
        
        listTableView.delegate = self
        listTableView.dataSource = self
         
        self.fetchUnivList(completionHandler: {
            [weak self] result in
            guard let self = self else{return}
            
            switch result{
            case let .success(result):
                allUniv = result
            case let .failure(error):
                print(error.localizedDescription)
            }
            
        })
    }
    
    private func setUpSearchController(){
        
        listTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "University Name"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchController.searchBar.sizeToFit()
    }
    
   
    
    func fetchUnivList(completionHandler: @escaping(Result<[Univ], Error>) -> Void){
        let url = "http://universities.hipolabs.com/search"
        let param = ["country" : country]
        
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: ["Content-Type" : "application/json", "Accept" : "application/json"])
            .responseData(completionHandler: {
                response in
                
                switch response.result{
                case let .success(data):
                    do{
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([Univ].self, from: data)
                        completionHandler(.success(result))
                    }
                    catch{
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                }
            })
    }
    

}


extension UnivListViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterUniv.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UnivCell", for: indexPath) as? UnivTableViewCell else{return UITableViewCell()}
        
        let univ = filterUniv[indexPath.row]
        
        cell.nameLabel.text = univ.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmailRegisterVC") as? EmailRegisterViewController else{return}
        
        vc.university = filterUniv[indexPath.row].name
        vc.tempCountry = filterUniv[indexPath.row].country
        searchController.searchBar.isHidden = true
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
}


extension UnivListViewController: UISearchResultsUpdating{
    func filterContentForSearchText(_ searchText: String){
        filterUniv = allUniv.filter({(univ) -> Bool in
            return univ.name.lowercased().contains(searchText.lowercased())
        })
        
        listTableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
}
