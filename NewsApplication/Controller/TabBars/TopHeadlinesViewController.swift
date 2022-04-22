//
//  TopHeadlinesViewController.swift
//  NewsApplication
//
//  Created by Nurzhan on 19.04.2022.
//

import UIKit
import SnapKit
import Alamofire

class TopHeadlinesViewController: UIViewController {
    
    private var totalPage = 1
    private var currentPage = 1
    private var service = AppService(type: .topHeadlines)
    private var newsConvert = News()
    static var newsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        return tableView
    }()
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Top Headlines"
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.backBarButtonItem?.tintColor = .white
        
        //TableView Data source, delegate
        TopHeadlinesViewController.newsTableView.dataSource = self
        TopHeadlinesViewController.newsTableView.delegate = self
        TopHeadlinesViewController.newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "TopHeadlines")
        
        view.addSubview(TopHeadlinesViewController.newsTableView)
        
        TopHeadlinesViewController.newsTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        fetchData(page: 1)
    }
    var topHeadlinesDB = DataStorage.shared.topHeadlines
    
    func fetchData(page: Int) {
        DispatchQueue.main.async {

            self.service.page = page
            
            self.service.sendRequest { result in
                switch result {
                case .success(let newsConvert):
                    if self.service.page == 1 {
                        self.newsConvert.articles = []
                    }
                    self.topHeadlinesDB.append(contentsOf: newsConvert.articles)
                    
                    TopHeadlinesViewController.newsTableView.reloadData()
    
                    if newsConvert.totalResults < 10 {
                        self.totalPage = newsConvert.totalResults
                    } else {
                        self.totalPage = newsConvert.totalResults/10
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
}

//TableViewDataSource, TableViewDelegate
extension TopHeadlinesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topHeadlinesDB.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = TopHeadlinesViewController.newsTableView.dequeueReusableCell(withIdentifier: "TopHeadlines", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: topHeadlinesDB[indexPath.row])
        
        if(indexPath.row == topHeadlinesDB.count - 1) {
            loadMoreData()
        }
        return cell
    }
    
    func loadMoreData() {
        print("Loading...")
        currentPage += 1
        fetchData(page: currentPage)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TopHeadlinesViewController.newsTableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = NewsDetailsViewController(isSavedNews: false)
        viewController.news = topHeadlinesDB[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
