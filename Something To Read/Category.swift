//
//  Category.swift
//  Something To Read
//
//  Created by Bartosz Klimek on 20/06/2022.
//

import Foundation

struct Category: Codable {
    var results: [CategoriesResult]
}

struct CategoriesResult: Codable {
    var listName: String
}
