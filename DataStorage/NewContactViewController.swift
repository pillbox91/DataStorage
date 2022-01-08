//
//  NewContactViewController.swift
//  DataStorage
//
//  Created by Андрей Аверьянов on 08.01.2022.
//

import UIKit

protocol NewContactViewControllerDelegate {
    func saveContact(_ contatc: String)
}

class NewContactViewController: UIViewController {
    
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    var delegate: NewContactViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.addTarget(
            self,
            action: #selector(firstNameTextFieldDidChanged),
            for: .editingChanged
        )
    }
    
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        saveAndExit()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc private func firstNameTextFieldDidChanged() {
        guard let firstName = firstNameTextField.text else { return }
        doneButton.isEnabled = !firstName.isEmpty ? true : false
    }
    
    @objc private func saveAndExit() {
        guard let firstName = firstNameTextField.text else {return}
        guard let lastName = lastNameTextField.text else {return}
        delegate.saveContact("\(firstName) \(lastName)")
        dismiss(animated: true)
    }
}
