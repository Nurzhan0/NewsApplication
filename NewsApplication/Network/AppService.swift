//
//  AppService.swift
//  NewsApplication
//
//  Created by Nurzhan on 20.04.2022.
//

import UIKit
import Alamofire

class AppService {
    var type: NewsType
    var page = 1
    private let pageSize = 10
    private let key = "f79cdeefd41e4c0c8ec903c6a6e65dd6"

//    private let key = "8c6262f6a187411ea8e061745f064214"
    
    private let url = "https://newsapi.org/v2/"
    private let query = "q="
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(type: NewsType) {
        self.type = type
    }
    
    enum NewsType {
        case all
        case topHeadlines
    }
    
    func getURL() -> String {
        switch type {
        case .all:
            return "\(url)everything?\(query)war&language=en&pageSize=\(pageSize)&page=\(page)&apiKey=\(key)"
        case .topHeadlines:
            return "\(url)top-headlines?\(query)war&pageSize=\(pageSize)&page=\(page)&apiKey=\(key)"
        }
    }
    
    func sendRequest(completion: @escaping (Result<News, Error>) -> Void) {
        print("Request page: \(page)")
        AF.request(self.getURL())
            .validate(statusCode: 200..<300)
            .responseDecodable(of: News.self, decoder: decoder) { response in
                switch response.result {
                case .success(let value):
                    print("Success request")
                    completion(.success(value))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
}
