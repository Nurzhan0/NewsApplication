//
//  NewsDetailsViewController.swift
//  NewsApplication
//
//  Created by Nurzhan on 20.04.2022.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    var isSavedNews: Bool
    
    var news: Articles? {
        didSet {
            guard let news = news else { return }
            sourceNameLabel.text = news.source?.name
            titleLabel.text = news.title
            descriptionLabel.text = news.description
            url = news.urlToImage
            contentLabel.text = news.content
            
            let defaultImage = "https://zonerantivirus.com/wp-content/uploads/default-image.png"
            image.load(url: URL(string: news.urlToImage ?? defaultImage)!)
        }
    }
    
    init(isSavedNews: Bool) {
        self.isSavedNews = isSavedNews
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var url: String?
    
    private var decoration: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor(red: 6/255, green: 108/255, blue: 219/255, alpha: 1)
        return view
    }()
    
    private var decoration1: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor(red: 6/255, green: 108/255, blue: 219/255, alpha: 1)
        return view
    }()
    
    private var image: UIImageView = {
        let image = UIImage(named: "default-image")?.preparingForDisplay()
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var sourceNameLabel: UILabel = {
        let label = UILabel()
        label.text = "???"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "???"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 10
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "???"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "???"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private var saveButton: UIButton = {
        let configuration = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let image = UIImage(systemName: "bookmark", withConfiguration: configuration)
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(red: 6/255, green: 108/255, blue: 219/255, alpha: 1)
        return button
    }()
    
    //LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [decoration, decoration1, image, sourceNameLabel, descriptionLabel, titleLabel, contentLabel, saveButton].forEach { item in
            view.addSubview(item)
        }
        setConstraint()
        
        if isSavedNews {
            saveButton.isEnabled = false
            saveButton.tintColor = .white
        }
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        let configuration = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let image = UIImage(systemName: "bookmark.fill", withConfiguration: configuration)
        saveButton.setImage(image, for: .normal)
        saveButton.isEnabled = false
        DataStorage.shared.savedNews.append(news ?? Articles())
        SavedViewController.newsTableView.reloadData()
    }
    
    func setConstraint() {
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(380)
            make.width.equalTo(UIScreen.main.bounds.size.width)
        }
        
        decoration1.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(sourceNameLabel.snp.height)
            make.width.equalTo(6)
        }
        
        sourceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.leading.equalTo(decoration1).offset(20)
            make.trailing.equalTo(saveButton.snp.leading)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(24)
            make.leading.equalTo(sourceNameLabel.snp.trailing).inset(16)
            make.size.equalTo(24)
        }
        
        decoration.snp.makeConstraints { make in
            make.top.equalTo(sourceNameLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(titleLabel.snp.height)
            make.width.equalTo(6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceNameLabel.snp.bottom).offset(16)
            make.leading.equalTo(decoration.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(16)
        }
    }
}
