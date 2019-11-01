//
//  DataManager.swift
//  TestTaskForVK
//
//  Created by Дмитрий Ю on 28.10.2019.
//  Copyright © 2019 Дмитрий Ю. All rights reserved.
//

import Foundation
import Alamofire  //использую этот фрейморк для работы с запросами к API

//Функция которая возвращает список всех "друзей" c их параметрами в замыкании
//https://api.vk.com/method/friends.get?user_id=...&fields=bdate&access_token=...&v=5.102
func loadDataForFriends(userId : String, token : String, complition : @escaping([String:StructForFriends]) -> Void ) {
    let param : [String: Any] = [
        "user_id" : userId,
        "fields" : "screen_name,photo_100,sex,relation",
        "access_token" : token,
        "v" : "5.102"
    ]
    AF.request("https://api.vk.com/method/friends.get?user_id=", parameters: param).responseJSON
        { responseJSON in
            do {
                let structure = try JSONDecoder().decode([String:StructForFriends].self, from: responseJSON.data!)
                complition(structure)
            } catch let error { print(error)}
        }
    print("viewDidLoad ended")
}

//Функция которая возвращает параметры пользователя в замыкании
//https://api.vk.com/method/users.get?user_id=...&fields=bdate,nickname,photo_50,sex,relation&access_token=...&v=5.103
func loadDataForUser(userId : String, token : String, complition : @escaping(UserData) -> Void ) {
    let param : [String: Any] = [
        "user_id" : userId,
        "fields" : "screen_name,photo_100,sex,relation",
        "access_token" : token,
        "v" : "5.103"
    ]
    AF.request("https://api.vk.com/method/users.get?user_id=", parameters: param).responseJSON
        { responseJSON in
            do {
                let structure = try JSONDecoder().decode(UserData.self, from: responseJSON.data!)
                complition(structure)
            } catch let error { print(error)}
        }
    print("viewDidLoad ended")
}
