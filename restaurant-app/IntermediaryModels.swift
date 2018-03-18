//
//  IntermediaryModels.swift
//  restaurant-app
//
//  Created by Paulina Van der Doe on 16/03/2018.
//  Copyright © 2018 Paulina Van der Doe. All rights reserved.
//

import Foundation

// Intermediary model for categories.
struct Categories: Codable {
    let items: [MenuItem]
}

// Intermediary models for storing preparatin time. 
struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
