//
//  Article.swift
//  NewsApplication
//
//  Created by Nurzhan on 19.04.2022.
//

import UIKit

struct News: Codable {
    var status: String?
    let totalResults: Int
    var articles: [Articles]
    
    init() {
        status = "!!!"
        totalResults = 0
        articles = []
    }
}
