//
//  Article.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import Foundation

struct Launches: Decodable{
    var id: String
}

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
    var launches: [Launches]
    //var launches: String?
    //var events: String?
}

