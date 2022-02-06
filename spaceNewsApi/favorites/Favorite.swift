//
//  Favorite.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 05/02/2022.
//

import Foundation

struct Favorite: Decodable {
    
    var id: String?
    var url: String?
    var title: String?
    var image: String?
    var newsSite: String?
    var summary: String?
}
