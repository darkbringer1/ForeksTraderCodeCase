//
//  TextFieldWithPadding.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 19.12.2022.
//

import UIKit

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 2,
        left: 4,
        bottom: 2,
        right: 4
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
