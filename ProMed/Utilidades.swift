//
//  Utilidades.swift
//  ProMed
//
//  Created by Luis Luna on 2/15/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation
import UIKit

final class Utilidades {
    
    static func showAlert(title: String, text: String?, sender: UIViewController) {
        
        let alert = UIAlertController.init(title: title, message: text, preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
  
        sender.present(alert, animated: true)
        
        
        
    }
    
    
    
    
    
    
    
    
    
}

extension UITextField {
    
    func setBottomLine(borderColor: UIColor) {
        
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.clear
        
        let borderLine = UIView()
        let height = 1.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)
        
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
    
    func setBottomLineWithBackground(borderColor: UIColor, background: UIColor) {
        
        self.backgroundColor = background
        self.layer.cornerRadius = 10
        
        let borderLine = UIView()
        let height = 1.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)
        
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
    
    func customPlaceHolder(color: UIColor){
        var placeholderText = ""
        if self.placeholder != nil{
            placeholderText = self.placeholder!
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
}
