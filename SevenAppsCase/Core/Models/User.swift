//
//  User.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
    
    var avatarURL: String {
            return "https://api.dicebear.com/7.x/avataaars/png?seed=\(id)"
        }
}

struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipCode: String
    let geo: Geo
    
    enum CodingKeys: String, CodingKey{  // codingkey kullan diğerlerinde
        // case street, suite, city, zipcode
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipCode = "zipcode"
        case geo = "geo"
    }
}

struct Geo: Decodable {
    let lat: String
    let lng: String
}

struct Company: Decodable {
    let name: String
    let catchPhrase: String
    let bs: String
}
