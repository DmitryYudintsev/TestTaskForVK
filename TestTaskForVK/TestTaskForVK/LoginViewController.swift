//
//  LoginViewController.swift
//  TestTaskForVK
//
//  Created by Дмитрий Ю on 30.10.2019.
//  Copyright © 2019 Дмитрий Ю. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {
    let clientId = "7186614"  //ID приложения
    var token = ""
    var userId = ""
    var webView : WKWebView!
    private let webUrl = "https://oauth.vk.com/authorize?client_id=7186614&display=mobile&redirect_uri=https://oauth.vk.com/blank.html/callback&scope=friends&response_type=token&v=5.103&state=123456"
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func observeValue(forKeyPath keyPath : String?, of object: Any?, change : [NSKeyValueChangeKey : Any]?, context : UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            //print(Float(webView.estimatedProgress))
            print(webView.url?.absoluteString ?? "")
            if webView.estimatedProgress == 1.0 {  //Проверяем загрузку страницы
                self.token = String(webView.url!.absoluteString) //Сохраняем урл с token
                self.userId = String(webView.url!.absoluteString) //Сохраняем урл с userID
                //В этом условии вырезаем token из строки урла
                if let range = token.range(of: "n=") {
                    self.token = token.substring(from: range.upperBound)
                }
                if let range = token.range(of: "&") {
                    self.token = token.substring(to: range.lowerBound)
                }
                //В этом условии вырезаем userId из строки урла
                if let range = userId.range(of: "id=") {
                    self.userId = userId.substring(from: range.upperBound)
                }
                if let range = userId.range(of: "&st") {
                    self.userId = userId.substring(to: range.lowerBound)
                }
//                Если токен не пустой, тогда сегвей на MainTableView
//                if token != nil {
//                    let vc = storyboard?.instantiateViewController(withIdentifier: "id1")
//                    self.present(vc!, animated: true, completion: nil)
//
//                    dest?.token = self.token
//                    dest?.userId = self.userId
//                }
                print("My token=" + token)
                print("My userID=" + userId)
            }
        }
    }
//===============================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let myURL = URL(string : webUrl)
        let myRequest = URLRequest(url : myURL!)
        webView.load(myRequest)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    // MARK: - Navigation
    
    //Передаем данные в MainTableViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue1" {
            let dest = segue.destination as? MainTableViewController
            dest?.token = self.token
            dest?.userId = self.userId
        }
    }
 
}
    
   
    

