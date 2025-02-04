//
//  User.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company

    // Kullanıcı için avatar URL oluşturur
    var avatarURL: String {
        "https://api.dicebear.com/7.x/avataaars/png?seed=\(id)"
    }

    // JSON verisini modele eşlemek için kullanılan anahtarlar
    enum CodingKeys: String, CodingKey {
        case id, name, username, email, phone, website, address, company
    }
}

struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipCode: String
    let geo: Geo

    enum CodingKeys: String, CodingKey {
        case street, suite, city
        case zipCode = "zipcode" // JSON'daki `zipcode` değeri `zipCode` olarak okunur
        case geo
    }
}

struct Geo: Decodable {
    let latitude: String
    let longitude: String

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

struct Company: Decodable {
    let name: String
    let catchPhrase: String
    let businessType: String

    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase = "catchPhrase"
        case businessType = "bs"
    }
}
