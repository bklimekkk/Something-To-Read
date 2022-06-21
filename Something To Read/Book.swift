//
//  Book.swift
//  Something To Read
//
//  Created by Bartosz Klimek on 20/06/2022.
//

import Foundation

struct Book: Codable {
    var results: BooksResult
}

struct BooksResult: Codable {
    var books: [TheBook]
}

struct TheBook: Codable {
    
    var title: String
    var bookImage: String
    var author: String
    var description: String
    var buyLinks: [BuyLink]
}

struct BuyLink: Codable {
    var name: String
    var url: String
}
