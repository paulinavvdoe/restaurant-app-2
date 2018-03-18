//
//  MenuItem.swift
//  restaurant-app
//
//  Created by Paulina Van der Doe on 14/03/2018.
//  Copyright © 2018 Paulina Van der Doe. All rights reserved.
//

import Foundation

// Structure for storing the information about menu items.
struct MenuItem: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case category
        case imageURL = "image_url"
    }
}

struct MenuItems: Codable {
    let items: [MenuItem]
}

