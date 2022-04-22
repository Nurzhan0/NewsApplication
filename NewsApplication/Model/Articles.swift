//
//  News.swift
//  NewsApplication
//
//  Created by Nurzhan on 19.04.2022.
//

import UIKit

struct Articles: Codable {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var puplishedAt: String?
    var content: String?
}
