//
//  NumpadTextField.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 10.07.2024.
//

import UIKit

class NumpadTextField: UITextField, VCInsides {
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Setup view
    
    func configureContent() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 0))
        self.textColor = .white
        self.tintColor = .white
        self.keyboardType = .decimalPad
        self.delegate = self
        
        let tfAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: tfAttributes)
    }
}

//MARK: - UITextFieldDelegate

extension NumpadTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text, let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                
                if string.isEmpty {
                    return true
                }
                
                if updatedText == "00" || updatedText == "," {
                    return false
                }
                
                if updatedText.filter({ $0 == "," }).count > 1 {
                    return false
                }
                
                if updatedText.count > 1 && updatedText.first == "0" && !updatedText.contains(",") {
                    return false
                }
            }
            return true
        }
}
