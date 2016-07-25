//
//  ViewController.swift
//  ValidatedSignUp
//
//  Created by Flatiron School on 7/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var textFields: [UITextField] = []
    
    // MARK: - Validation
    
    func containsWhitespace(string: String) -> Bool {
        return string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" || string == ""
    }
    
    func validateTextField(textField: UITextField) -> Bool {
        let string = textField.text
        
        if textField == firstNameField || textField == lastNameField || textField == usernameField {
            if !containsWhitespace(string!) {
                if string?.rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet()) == nil {
                    return true
                } else {
                    alert("Digits are not allowed in names.", textField: textField)
                }
                
            } else {
                alert("Please enter your \(textField.placeholder!.lowercaseString).", textField: textField)
            }
        }
        
        if textField == emailField {
            if !containsWhitespace(string!) {
                let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
                let email = NSPredicate(format: "SELF MATCHES %@", regex)
                
                if email.evaluateWithObject(string!) {
                    return true
                } else {
                    alert("Please enter a valid email address.", textField: textField)
                }
                
            } else {
                alert("Please enter your \(textField.placeholder!.lowercaseString).", textField: textField)
            }
        }
        
        if textField == passwordField {
            if !containsWhitespace(string!) {
                if (textField.text?.characters.count < 6) {
                    alert("Password must be at least 6 characters.", textField: textField)
                } else {
                    return true
                }
                
            } else {
                alert("Please enter your \(textField.placeholder!.lowercaseString).", textField: textField)
            }
        }
        
        return false
    }
    
    func alert(message: String, textField: UITextField) {
        let alertController = UIAlertController(title: "Learn", message: message, preferredStyle: .Alert)
        
        let dismiss = UIAlertAction(title: "OK", style: .Cancel, handler: { (action) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        
        let clear = UIAlertAction(title: "Clear", style: .Default, handler: { (action) in
            textField.text = ""
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        
        alertController.addAction(dismiss)
        alertController.addAction(clear)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Text Field Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let index = textFields.indexOf(textField)!
        
        if (index < 4) {
            if validateTextField(textField) {
                let nextField = textFields[index + 1]
                nextField.enabled = true
                nextField.becomeFirstResponder()
                
                return true
            }
        }
        
        if validateTextField(textField) {
            submitButton.enabled = true
            textField.resignFirstResponder()
        }
        
        return false
    }
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        textFields = [firstNameField, lastNameField, emailField, usernameField, passwordField]
        
        for textField in textFields {
            textField.delegate = self
        }
        
        firstNameField.becomeFirstResponder()
    }
}
