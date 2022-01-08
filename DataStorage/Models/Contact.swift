//
//  Contact.swift
//  DataStorage
//
//  Created by Андрей Аверьянов on 08.01.2022.
//

import Foundation

struct Contact: Codable {
    let firstName: String
    let lastName: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
