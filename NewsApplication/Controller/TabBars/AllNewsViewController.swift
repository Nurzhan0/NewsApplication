//
//  AllNewsViewController.swift
//  NewsApplication
//
//  Created by Nurzhan on 19.04.2022.
//

import UIKit
import SnapKit
import Alamofire

class AllNewsViewController: UIViewController {
    
    private var totalPage = 1
    private var currentPage = 1
    private var service = AppService(type: .all)
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
        navigationItem.title = "Everything"
        navigationItem.backBarButtonItem = UIBarButtonItem (
            title: "Back",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.backBarButtonItem?.tintColor = .white
        
        //TableView Data source, delegate
        AllNewsViewController.newsTableView.dataSource = self
        AllNewsViewController.newsTableView.delegate = self
        AllNewsViewController.newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "Everything")
        
        view.addSubview(AllNewsViewController.newsTableView)
        
        AllNewsViewController.newsTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        fetchData(page: 1)
    }
    
    var allNewsDB = DataStorage.shared.allNews
    
    func fetchData(page:Int) {
        DispatchQueue.main.async {
            self.service.page = page
            
            self.service.sendRequest { result in
                switch result {
                case .success(let newsConvert):
                    if self.service.page == 1 {
                        self.newsConvert.articles = []
                    }
                    
                    self.allNewsDB.append(contentsOf: newsConvert.articles)
                    AllNewsViewController.newsTableView.reloadData()
                    
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
extension AllNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allNewsDB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Everything", for: indexPath) as? NewsTableViewCell else { return UITableViewCell()}
        cell.configure(with: allNewsDB[indexPath.row])
        
        if (indexPath.row == allNewsDB.count - 1) {
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
        AllNewsViewController.newsTableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = NewsDetailsViewController(isSavedNews: false)
        viewController.news = allNewsDB[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
