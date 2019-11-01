//
//  ViewController.swift
//  TestTaskForVK
//
//  Created by Дмитрий Ю on 28.10.2019.
//  Copyright © 2019 Дмитрий Ю. All rights reserved.
//

import UIKit

class Screen2_ViewController: UIViewController {
    
    var userId = ""  //Получаем из Screen1_TableViewController
    var token = ""   //Получаем из Screen1_TableViewController
    var sexDictinary = [0 : "пол не указан",
                        1 : "женский",
                        2 : "мужской" ]
    
    var relationDictinary = [0 : "не указано",
                             1 : "не женат/не замужем",
                             2 : "есть друг/есть подруга",
                             3 : "помолвлен/помолвлена",
                             4 : "женат/замужем",
                             5 : "всё сложно",
                             6 : "в активном поиске",
                             7 : "влюблён/влюблена",
                             8 : "в гражданском браке" ]
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var lastNameLabel : UILabel!
    @IBOutlet weak var nickNameLabel : UILabel!
    @IBOutlet weak var sex : UILabel!
    @IBOutlet weak var relation : UILabel!
    @IBOutlet weak var photo_100 : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDataForUser(userId: userId, token: token) {
            structure in
            let friend = structure.response
                if friend[0].relation != nil {
                    let relation = friend[0].relation!
                    self.relation.text = self.relationDictinary[relation]
                    } else {
                    self.relation.text = self.relationDictinary[0]
                }
            //Подгружаем фото по ссылке
                let photo_100 = String(friend[0].photo_100)
                    if let data = try? Data(contentsOf: URL(string : photo_100)!) {
                        self.photo_100.image = UIImage(data: data)
                        self.photo_100.layer.cornerRadius = self.photo_100.frame.size.width / 2
                        self.photo_100.clipsToBounds = true
                    }
            self.navigationItem.title = friend[0].first_name + " " + friend[0].last_name
            self.nameLabel.text = friend[0].first_name
            self.lastNameLabel.text = friend[0].last_name
            self.nickNameLabel.text = friend[0].screen_name
            self.sex.text = self.sexDictinary[friend[0].sex]
        }
    }
}

