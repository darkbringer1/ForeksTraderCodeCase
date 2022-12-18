//
//  StocksTableView.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 18.12.2022.
//

import UIKit
import BaseComponents


protocol StocksTableViewOutputProtocol: AnyObject {
    func numberOfItems() -> Int
    func cellForItem(at indexPath: IndexPath) -> StockCellData?
    func didSelectItem(at indexPath: IndexPath)
}

class StocksTableView: BaseView {
    
    weak var output: StocksTableViewOutputProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        tableView.register(StocksTableViewCell.self, forCellReuseIdentifier: StocksTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
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
        output?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = output?.cellForItem(at: indexPath),
              let cell = tableView.dequeueReusableCell(withIdentifier: StocksTableViewCell.identifier, for: indexPath) as? StocksTableViewCell else { return UITableViewCell() }
        cell.setRowData(data: data)
        return cell
    }
}
