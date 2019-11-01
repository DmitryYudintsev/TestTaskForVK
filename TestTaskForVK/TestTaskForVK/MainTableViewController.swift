//
//  MainTableViewController.swift
//  TestTaskForVK
//
//  Created by Дмитрий Ю on 31.10.2019.
//  Copyright © 2019 Дмитрий Ю. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var userId = ""  //Получаем из LoginViewController
    var token = ""   //Получаем из LoginViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataForUser(userId: userId, token: token) {
        structure in
        let friend = structure.response
            self.navigationItem.title = friend[0].first_name + " " + friend[0].last_name
        }
//        print("Main=" + token)
//        print("Main=" + userId)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegueToScreen2" {
            let dest = segue.destination as? Screen2_ViewController
            dest?.token = self.token
            dest?.userId = self.userId
        } else {
            let dest = segue.destination as? Screen1_TableViewController
            dest?.token = self.token
            dest?.userId = self.userId
        }
    }
}
