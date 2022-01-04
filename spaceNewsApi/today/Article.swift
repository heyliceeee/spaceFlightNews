//
//  Article.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import Foundation

struct Article: Codable {
    var id: Int?
    var title: String?
    var url: String?
    var imageUrl: String?
    var newsSite: String?
    var summary: String?
    var publishedAt: String?
    var updatedAt: String?
    var featured: String?
    var launches: String?
    var events: String?
    
    
    enum CondingKeys: String, CodingKey {
        case id, title, url, imageUrl, newsSite, summary, publishedAt, updatedAt, featured, launches, events
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //modificar dados (ex: formato das datas)
        let publishedAtValue = try container.decode(String.self, forKey: .publishedAt)
        publishedAt = "\(publishedAtValue)"
        
        let updatedAtValue = try container.decode(String.self, forKey: .updatedAt)
        updatedAt = "\(updatedAtValue)"
        
        //resto das propriedades
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        newsSite = try container.decode(String.self, forKey: .newsSite)
        summary = try container.decode(String.self, forKey: .summary)
        featured = try container.decode(String.self, forKey: .featured)
        launches = try container.decode(String.self, forKey: .launches)
        events = try container.decode(String.self, forKey: .events)
    }
}
