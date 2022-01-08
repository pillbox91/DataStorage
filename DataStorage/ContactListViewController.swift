//
//  ContactListViewController.swift
//  DataStorage
//
//  Created by Андрей Аверьянов on 08.01.2022.
//

import UIKit

class ContactListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var contacts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newContactVC = segue.destination as! NewContactViewController
        newContactVC.delegate = self
//        newContactVC.modalPresentationStyle = .fullScreen
    }
}

// MARK: - UITableViewDataSource
extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//MARK: - NewContactViewControllerDelegate
extension ContactListViewController: NewContactViewControllerDelegate {
    func saveContact(_ contact: String) {
        contacts.append(contact)
        tableView.reloadData()
    }
}
