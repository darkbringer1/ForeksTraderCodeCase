//
//  StocksTableView.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 18.12.2022.
//

import UIKit
import BaseComponents


protocol StocksTableViewDataProvider: AnyObject {
    func numberOfItems() -> Int
    func cellForItem(at indexPath: IndexPath) -> StockRowData?
    func didSelectItem(at indexPath: IndexPath)
}

class StocksTableView: BaseView {
    weak var dataProvider: StocksTableViewDataProvider?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 250
        tableView.register(StocksTableViewCell.self, forCellReuseIdentifier: StocksTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .darkGray
//        tableView.refreshControl = UIRefreshControl()
//        tableView.refreshControl?.addTarget(self, action: #selector(reloadTableViewData), for: .valueChanged)
        return tableView
    }()
    
//    private lazy var spinner: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView()
//        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
//        return spinner
//    }()
    
    override func setupView() {
        super.setupView()
        addTableView()
    }
    
    private func addTableView() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func reloadTableView() {
//        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    @objc func reloadTableViewData() {
        
    }
}

extension StocksTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataProvider?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StocksTableViewCell.identifier,
                                                       for: indexPath) as? StocksTableViewCell,
                let data = dataProvider?.cellForItem(at: indexPath) else { return UITableViewCell() }
        cell.setRowData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataProvider?.didSelectItem(at: indexPath)
    }
}
