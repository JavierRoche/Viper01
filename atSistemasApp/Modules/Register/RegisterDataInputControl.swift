//
//  RegisterDataInputControl.swift
//  atSistemasApp
//
//  Created by APPLE on 20/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

// MARK: UITextField Delegate

extension RegisterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nextTextField = textField.superview?.viewWithTag(textField.tag + 1) else {
            textField.resignFirstResponder()
            return true
        }
        nextTextField.superview?.viewWithTag(textField.tag + 1)?.becomeFirstResponder()
        return true
    }
    
    /// Characters number control
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case emailText:
            let currentText = emailText.text ?? String()
            guard let range = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            
            return updatedText.count < 50
            
        case passwordText:
            let currentText = passwordText.text ?? String()
            guard let range = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            
            return updatedText.count < 25
            
        case repeatText:
            let currentText = repeatText.text ?? String()
            guard let range = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            
            return updatedText.count < 25
          
        default:
            return false
        }
    }
}
