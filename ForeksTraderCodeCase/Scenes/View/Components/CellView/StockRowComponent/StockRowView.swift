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
    private(set) var newStockItem: [String: String]?
    private(set) var oldStockItem: [String: String]?
    
    init(name: String,
         leftData: String,
         rightData: String,
         date: String,
         newStockItem: [String: String]? = nil,
         oldStockItem: [String: String]? = nil) {
        self.name = name
        self.leftData = leftData
        self.rightData = rightData
        self.date = date
        self.newStockItem = newStockItem
        self.oldStockItem = oldStockItem
    }
}

class StockRowView: GenericBaseView<StockRowData> {
    private lazy var containerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = .clear
        return temp
    }()
    
    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [directionView, stockNameStack, leftLabel, rightLabel])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis = .horizontal
        temp.alignment = .center
        temp.contentMode = .scaleToFill
        temp.spacing = 5
        return temp
    }()
    
    private lazy var directionView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = 4
        return temp
    }()
    
    private lazy var directionArrow: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.tintColor = .white
        temp.contentMode = .scaleAspectFit
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
        temp.font = UIFont.systemFont(ofSize: 14, weight: .bold)
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
        temp.font = UIFont.systemFont(ofSize: 10, weight: .light)
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
        temp.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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
        temp.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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
            
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            
            directionView.widthAnchor.constraint(equalToConstant: 15),
            directionView.leadingAnchor.constraint(equalTo: directionArrow.leadingAnchor, constant: -2),
            directionView.trailingAnchor.constraint(equalTo: directionArrow.trailingAnchor, constant: 2),
            directionView.bottomAnchor.constraint(equalTo: directionArrow.bottomAnchor, constant: 4),
            directionView.topAnchor.constraint(equalTo: directionArrow.topAnchor, constant: -4),
        ])
    }
    
    override func loadDataView() {
        super.loadDataView()
        guard let data = getData() else { return }
        var leftText: String {
            if data.leftData == "pdd" {
                if let percentage = data.oldStockItem?[data.leftData] {
                    leftLabel.textColor = (Double(percentage) ?? 0) < 0 ? .red : .green
                    return "%" + percentage
                } else { return "" }
            } else if data.leftData == "ddi" {
                if let value = data.oldStockItem?[data.leftData] {
                    leftLabel.textColor = (Double(value) ?? 0) < 0 ? .red : .green
                    return value
                } else { return "" }
            } else {
                return (data.oldStockItem?[data.leftData] ?? "")
            }
        }
        var rightText: String {
            if data.rightData == "pdd" {
                if let percentage = data.oldStockItem?[data.rightData] {
                    rightLabel.textColor = (Double(percentage) ?? 0) < 0 ? .red : .green
                    return "%" + percentage
                } else { return "" }
            } else if data.rightData == "ddi" {
                if let value = data.oldStockItem?[data.rightData] {
                    rightLabel.textColor = (Double(value) ?? 0) < 0 ? .red : .green
                    return value
                } else { return "" }
            } else {
                return (data.oldStockItem?[data.rightData] ?? "")
            }
        }
        leftLabel.text = leftText
        rightLabel.text = rightText
        stockName.text = data.name
        stockLastUpdated.text = data.date
        updateCell(with: calculateStockState(oldItem: data.oldStockItem,
                                             newItem: data.newStockItem))
        if data.oldStockItem?["clo"] != data.newStockItem?["clo"] {
            updatedCell()
        }
    }
    
    private func updatedCell() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.containerView.backgroundColor = .gray
            self?.containerView.backgroundColor = .clear
        }
    }
    
    private func updateCell(with state: StockState) {
        switch state {
            case .stable:
                directionArrow.image = UIImage(systemName: "pause")
                directionView.backgroundColor = .gray
            case .increasing:
                directionArrow.image = UIImage(systemName: "chevron.up")
                directionView.backgroundColor = .green
            case .decreasing:
                directionArrow.image = UIImage(systemName: "chevron.down")
                directionView.backgroundColor = .red
        }
    }
    
    private func calculateStockState(oldItem: [String: String]?, newItem: [String: String]?) -> StockState {
        guard let oldItem = oldItem, let newItem = newItem else { return .stable }
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        let oldLeft = formatter.number(from: oldItem["las"] ?? "") ?? 0
        let newLeft = formatter.number(from: newItem["las"] ?? "") ?? 0
        
        if newLeft.doubleValue < oldLeft.doubleValue {
            return .decreasing
        } else if newLeft.doubleValue > oldLeft.doubleValue {
            return .increasing
        } else {
            return .stable
        }
    }
}

enum StockState {
    case stable
    case increasing
    case decreasing
}
