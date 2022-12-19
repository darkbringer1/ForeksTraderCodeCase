//
//  StocksHeaderView.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 18.12.2022.
//

import UIKit
import BaseComponents

protocol StocksHeaderDataProvider {
    func numberOfComponents() -> Int?
    func numberOfRows(in component: Int) -> Int
    func titleForRow(row: Int, in component: Int) -> String?
    func didSelect(row: Int, in component: Int)
}

class StocksHeaderData{}

class StocksHeaderView: GenericBaseView<StocksHeaderData> {
    var dataProvider: StocksHeaderDataProvider?
    
    private lazy var containerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = .white
        return temp
    }()
    
    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [symbolLabel, textFieldOne, textFieldTwo])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis = .horizontal
        temp.alignment = .fill
        temp.spacing = 16
        return temp
    }()
    
    private lazy var symbolLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = "Sembol"
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .left
        return temp
    }()
    
    
    private lazy var textFieldOne: UITextField = {
        let temp = UITextField()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.inputView = pickerView
        temp.backgroundColor = .gray
        temp.layer.cornerRadius = 6
        temp.layer.borderWidth = 1
        
        return temp
    }()
    
    private lazy var textFieldTwo: UITextField = {
        let temp = UITextField()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.inputView = pickerView
        temp.backgroundColor = .gray
        return temp
    }()
    
    private lazy var pickerView: UIPickerView = {
        let temp = UIPickerView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.dataSource = self
        temp.delegate = self
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
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            
            symbolLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            textFieldOne.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4),
            textFieldTwo.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4)
        ])
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        toolBar.setItems([doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        textFieldOne.inputAccessoryView = toolBar
        textFieldTwo.inputAccessoryView = toolBar
    }
    
    @objc func dismissPicker() {
        textFieldOne.endEditing(true)
        textFieldTwo.endEditing(true)
    }
    
    func reloadPickerData() {
        DispatchQueue.main.async { [weak self] in
            self?.pickerView.reloadAllComponents()
        }
    }
    
    func selectDefaultRows() {
        DispatchQueue.main.async { [weak self] in
            self?.pickerView.selectRow(0, inComponent: 0, animated: true)
            self?.pickerView.selectRow(0, inComponent: 1, animated: true)
            self?.textFieldOne.text = self?.dataProvider?.titleForRow(row: 0, in: 0)
            self?.textFieldTwo.text = self?.dataProvider?.titleForRow(row: 0, in: 1)
        }
    }
}

extension StocksHeaderView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        dataProvider?.numberOfComponents() ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataProvider?.numberOfRows(in: component) ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dataProvider?.titleForRow(row: row, in: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
            case 0:
                textFieldOne.text = dataProvider?.titleForRow(row: row, in: component)
            case 1:
                textFieldTwo.text = dataProvider?.titleForRow(row: row, in: component)
            default:
                break

        }
        dataProvider?.didSelect(row: row, in: component)
    }
}

