//
//  NewsViewModel.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/28/23.
//

import Foundation

import SwiftyJSON
import SDWebImageSwiftUI
import WebKit

class NewsViewModel: ObservableObject{
    @Published var datas = [News]()
    
    init() {
        let source = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d9089eb5e5094f9bb0fa2abbc9a9557d"
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, _, err in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            for i in json["articles"] {
                let title = i.1["title"].stringValue
                let description = i.1["description"].stringValue
                let url = i.1["url"].stringValue
                let image = i.1["urlToImage"].stringValue
                let id = i.1["publishedAt"].stringValue
                
                DispatchQueue.main.async {
                    self.datas.append(News(id: id, title: title, desc: description, url: url, image: image))
                }
            }
            
        }.resume()
    }
}

