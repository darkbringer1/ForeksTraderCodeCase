//
//  StockRowView.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 17.12.2022.
//

import UIKit
import BaseComponents

class StockRowData {
    private(set) var direction: String
    private(set) var name: String
    private(set) var criteria: String
    private(set) var diff: String
    
    init(direction: String,
         name: String,
         criteria: String,
         diff: String) {
        self.direction = direction
        self.name = name
        self.criteria = criteria
        self.diff = diff
    }
}

class StockRowView: GenericBaseView<StockRowData> {
    private lazy var containerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = .white
        return temp
    }()
    
    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [stockNameStack, criteriaLabel, diffLabel])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis = .horizontal
        temp.alignment = .fill
        temp.spacing = 16
        return temp
    }()
    
    private lazy var directionArrow: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        
        return temp
    }()
    
    private lazy var stockNameStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [stockName, stockLastUpdated])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis = .vertical
        return temp
    }()
    
    private lazy var stockName: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = " "
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .left
        return temp
    }()
    
    private lazy var stockLastUpdated: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = " "
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .left
        return temp
    }()
    
    private lazy var criteriaLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = " "
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .left
        return temp
    }()
    
    private lazy var diffLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = " "
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .left
        return temp
    }()
    
    override func setupView() {
        super.setupView()
        addComponents()
    }
    
    private func addComponents() {
        addSubview(containerView)
        containerView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16)
        ])}
    
    override func loadDataView() {
        super.loadDataView()
        guard let data = getData() else { return }
//        directionArrow.image = UIImage(systemName: data)
        stockName.text = data.name
//        stockLastUpdated.text = Date().formatted()
    }
}
