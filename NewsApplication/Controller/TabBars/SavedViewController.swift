//
//  SavedViewController.swift
//  NewsApplication
//
//  Created by Nurzhan on 19.04.2022.
//

import UIKit

class SavedViewController: UIViewController {
    
    static var newsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Saved"
        navigationItem.backBarButtonItem = UIBarButtonItem (
            title: "Back",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationController?.navigationBar.tintColor = .white
        
        //TableView DataSource, Delegate
        SavedViewController.newsTableView.dataSource = self
        SavedViewController.newsTableView.delegate = self
        SavedViewController.newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "Saved")
        
        view.addSubview(SavedViewController.newsTableView)
        
        SavedViewController.newsTableView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Saving...\(DataStorage.shared.savedNews.count)")
            DataStorage.shared.savedNews.remove(at: indexPath.row)
            print("Saving...\(DataStorage.shared.savedNews.count)")
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//TableViewDataSource, TableViewDelegate
extension SavedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataStorage.shared.savedNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = SavedViewController.newsTableView.dequeueReusableCell(withIdentifier: "Saved", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        cell.configure(with: DataStorage.shared.savedNews[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SavedViewController.newsTableView.deselectRow(at: indexPath, animated: true)
        SavedViewController.newsTableView.reloadData()
        let viewController = NewsDetailsViewController(isSavedNews: true)
        viewController.news = DataStorage.shared.savedNews[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
