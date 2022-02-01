//
//  Article.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import Foundation

struct Article: Decodable{
    
    var id: Int?
    var title: String?
    //var url: URL?
    var imageUrl: String?
    var newsSite: String?
    var summary: String?
    var publishedAt: String?
    var updatedAt: String?
    var featured: Bool?
    var launches: String?
    var events: String?
}
//class Article {
//
//    var id: Int?
//    var title: String?
//    //var url: URL?
//    var imageUrl: String?
//    var newsSite: String?
//    var summary: String?
//    var publishedAt: String?
//    var updatedAt: String?
//    var featured: Bool?
//    var launches: String?
//    var events: String?
//
//
//    init(id: Int, title: String, imageUrl: String, newsSite: String, summary: String, publishedAt: String, updatedAt: String, featured: Bool){
//
//        self.id = id
//        self.title = title
//        //self.url = url
//        self.imageUrl = imageUrl
//        self.summary = summary
//        self.newsSite = newsSite
//        self.publishedAt = publishedAt
//        self.updatedAt = updatedAt
//        self.featured = featured
//    }
//}
