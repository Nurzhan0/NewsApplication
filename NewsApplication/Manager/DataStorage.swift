//
//  DataStorage.swift
//  NewsApplication
//
//  Created by Nurzhan on 20.04.2022.
//

import UIKit
class DataStorage {
    static let shared = DataStorage()
    
    enum Key: String {
        case news
        case topHeadline
        case allNews
    }
    
    var savedNews: [Articles] = [] {
        didSet {
            let data = try? JSONEncoder().encode(savedNews)
            UserDefaults.standard.set(data, forKey: DataStorage.Key.news.rawValue)
        }
    }
    
    var topHeadlines: [Articles] = [] {
        didSet {
            let data = try? JSONEncoder().encode(topHeadlines)
            UserDefaults.standard.set(data, forKey: DataStorage.Key.topHeadline.rawValue)
        }
    }
    
    var allNews: [Articles] = [] {
        didSet {
            let data = try? JSONEncoder().encode(allNews)
            UserDefaults.standard.set(data, forKey: DataStorage.Key.allNews.rawValue)
        }
    }
    
    private init() {
        UserDefaults.standard.register(
            defaults: [DataStorage.Key.news.rawValue: Data()]
        )
        savedNews = getBookmarksValue(key: DataStorage.Key.news.rawValue)
        topHeadlines = getBookmarksValue(key: DataStorage.Key.topHeadline.rawValue)
        allNews = getBookmarksValue(key: DataStorage.Key.allNews.rawValue)
    }
    
    private func getBookmarksValue(key: String) -> [Articles] {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return [] }
        let value = try? JSONDecoder().decode([Articles].self, from: data)
        return value ?? []
    }
}
