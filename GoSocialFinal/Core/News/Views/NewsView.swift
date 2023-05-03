//
//  NewsView.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/28/23.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit

struct NewsView: View {
    
    @ObservedObject var list = NewsViewModel()
    
    var body: some View {
        
        NavigationView {
            
            List(list.datas) { i in
                
                NavigationLink(destination: webView(url: i.url).navigationBarTitle("", displayMode: .inline)) {
                    VStack (spacing: 15){
                        
                        
                        if i.image != "" {
                            WebImage(url: URL(string: i.image)!, options: .highPriority, context: nil)
                                .resizable()
                                .frame(width: 320, height: 200)
                                .cornerRadius(5)
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(i.title)
                                .fontWeight(.heavy)
                            Text(i.desc).lineLimit(2)
                            
                        }
//                        .navigationTitle("Trending")
                        
                    }
                    .padding(.vertical, 15)
                }
            }
        }
    }
}

struct webView: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: UIViewRepresentableContext<webView>) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: URL(string: url)!))
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<webView>) {
    }
}
