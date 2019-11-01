//
//  TableViewController.swift
//  TestTaskForVK
//
//  Created by Дмитрий Ю on 28.10.2019.
//  Copyright © 2019 Дмитрий Ю. All rights reserved.
//

import UIKit

class Screen1_TableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredFriendsMas = [Friend]()
    var friendsMas = [Friend]() //массив друзей
    var userId = ""  //Получаем из MainTableViewController
    var token = ""   //Получаем из MainTableViewController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataForFriends(userId : userId, token: token) {
        structure in
            let friendsStruc = [String](structure.keys)
            let friend = structure[friendsStruc[0]]!.items
            self.friendsMas = friend
            self.tableView.reloadData() //перезагружаем табличку
        }
        //насторойка SearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Friends"
        self.searchController.searchBar.becomeFirstResponder()

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredFriendsMas.count
        }
        return friendsMas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "IdCell", for: indexPath)
        let name = self.searchController.isActive ? self.filteredFriendsMas[indexPath.row] : self.friendsMas[indexPath.row]
        
        //Подгружаем фото по ссылке асинхронно в отдельной очереди
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue .async {
            let photo_100 = name.photo_100
            if let data = try? Data(contentsOf: URL(string : photo_100)!) {
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: data)
                    cell.imageView?.layer.cornerRadius = 20
                    cell.imageView?.clipsToBounds = true
                }
            }
        }
        cell.textLabel?.text = name.first_name + " " + name.last_name
        return cell

    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegueToScreen2" {
            let dest = segue.destination as? Screen2_ViewController
            let cell = self.tableView.indexPathForSelectedRow!
            let friendsSeg = self.searchController.isActive ? self.filteredFriendsMas[cell.row].id : self.friendsMas[cell.row].id
            //dest?.detailSeg = [friendsSeg]
            dest?.userId = String(friendsSeg)
            dest?.token = token
        }
    }
}
extension Screen1_TableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredFriendsMas = friendsMas.filter({ (friendsMas) -> Bool in
        let searchName = friendsMas.first_name.description + " " + friendsMas.last_name.description
            return searchName.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        tableView.reloadData()
    }
}
