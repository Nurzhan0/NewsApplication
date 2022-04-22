//
//  NewsTableViewCell.swift
//  NewsApplication
//
//  Created by Nurzhan on 20.04.2022.
//

import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell {
    private var articles = Articles()

    lazy var image: UIImageView = {
        return UIImageView(image: UIImage(named: "default-image")?.preparingForDisplay())
    }()
    
    lazy var sourceName: UILabel = {
        let label = UILabel()
        label.text = "?"
        label.textColor = UIColor(red: 6/255, green: 108/255, blue: 219/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "?"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 3
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        
        let items = [title, sourceName, image]
        items.forEach {
            item in contentView.addSubview(item)
        }
        setConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraint() {

        image.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(140)
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        sourceName.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.leading.equalTo(image.snp.trailing).offset(16)
        }
        
        title.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(sourceName.snp.bottom).offset(6)
            make.leading.equalTo(image.snp.trailing).offset(16)
        }
    }
    
    func configure(with viewModel: Articles) {
        articles = viewModel
        sourceName.text = viewModel.source?.name
        title.text = viewModel.title
        
        let defaultImage = "https://zonerantivirus.com/wp-content/uploads/default-image.png"
        
        image.load(url: URL(string: viewModel.urlToImage ?? defaultImage)!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        sourceName.text = nil
        title.text = nil
    }
}
