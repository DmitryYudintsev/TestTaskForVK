//
//  DataStructures.swift
//  TestTaskForVK
//
//  Created by Дмитрий Ю on 28.10.2019.
//  Copyright © 2019 Дмитрий Ю. All rights reserved.
//

import Foundation

//Базовая структура
struct Friend :Decodable {
    var first_name : String
    var last_name : String
    var screen_name : String?
    var photo_100 : String
    var sex : Int
    var relation : Int?
    var id : Int
}

//Структура описывающая JSON который отдает API VK https://api.vk.com/method/users.get?...
struct UserData :Decodable {
    var response = [Friend]()
}

//Структура описывающая JSON который отдает API VK https://api.vk.com/method/friends.get?...
struct StructForFriends : Decodable {
    var count : Int
    var items = [Friend]()
}

