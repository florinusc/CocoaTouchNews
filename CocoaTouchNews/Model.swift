//
//  Model.swift
//  CocoaTouchNews
//
//  Created by Florin Uscatu on 11/7/17.
//  Copyright © 2017 Florin Uscatu. All rights reserved.
//

import Foundation


struct InitialResponse: Decodable {
    
    var items: [Item]
}

struct Item: Decodable {
    var id: String
    var title: String
    var summary: String
    var content_html: String
    var url: String
    var datePublished: String?
    var author: Author
    
    struct Author: Decodable {
        var name: String
        var url: String
        var avatar: String
    }
}
