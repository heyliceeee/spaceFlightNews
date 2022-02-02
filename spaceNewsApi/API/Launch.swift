//
//  Launch.swift
//  spaceNewsApi
//
//  Created by Tiago Costa on 02/02/2022.
//

import Foundation

struct Launch: Decodable {
    
    var id: Int?
    var title: String?
    //var url: URL?
    var imageUrl: String?
    var newsSite: String?
    var summary: String?
    var publishedAt: String?
    var updatedAt: String?
    var featured: Bool?
    
}
