//
//  StockRowView.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 17.12.2022.
//

import UIKit
import BaseComponents

class StockRowData {
    private(set) var name: String
    private(set) var leftData: String
    private(set) var rightData: String
    private(set) var date: String
    private(set) var state: StockState
    
    init(name: String, leftData: String, rightData: String, date: String, state: StockState) {
        self.name = name
        self.leftData = leftData
        self.rightData = rightData
        self.date = date
        self.state = state
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
        let temp = UIStackView(arrangedSubviews: [directionView, stockNameStack, leftLabel, rightLabel])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis = .horizontal
        temp.alignment = .fill
        temp.spacing = 16
        return temp
    }()
    
    private lazy var directionView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var leftLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = " "
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .right
        return temp
    }()
    
    private lazy var rightLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = " "
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .right
        return temp
    }()
    
    override func setupView() {
        super.setupView()
        addComponents()
    }
    
    private func addComponents() {
        addSubview(containerView)
        containerView.addSubview(mainStackView)
        directionView.addSubview(directionArrow)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            
            directionView.widthAnchor.constraint(equalToConstant: 15),
            leftLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4),
            rightLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4),
            stockNameStack.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 2) - 15)
        ])
        directionView.bounds = directionArrow.bounds
    }
    
    override func loadDataView() {
        super.loadDataView()
        guard let data = getData() else { return }
        switch data.state {
            case .stable:
                break
            case .increasing:
                break
            case .decreasing:
                break
        }
        leftLabel.text = data.leftData
        rightLabel.text = data.rightData
        stockName.text = data.name
        stockLastUpdated.text = data.date
    }
}
