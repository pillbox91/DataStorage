//
//  StorageManager.swift
//  DataStorage
//
//  Created by Андрей Аверьянов on 08.01.2022.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let contactKey = "contacts"
    private let documentDerectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let archiveUrl: URL!
    
    private init() {
        archiveUrl = documentDerectory.appendingPathComponent("Contacts").appendingPathExtension("plist")
    }
    
//    func fetchContacts() -> [String] {
//        if let contacts =  userDefaults.value(forKey: contactKey) as? [String] {
//            return contacts
//        }
//        return []
//    }
//
//    func saveContacts(with contact: String) {
//        var contacts = fetchContacts()
//        contacts.append(contact)
//        userDefaults.set(contacts, forKey: contactKey)
//    }
//
//    func deleteContact(at index: Int) {
//        var contacts = fetchContacts()
//        contacts.remove(at: index)
//        userDefaults.set(contacts, forKey: contactKey)
//    }
    
    func fetchContacts() -> [Contact] {
        guard let data = userDefaults.object(forKey: contactKey) as? Data else {return []}
        guard let contacts = try? JSONDecoder().decode([Contact].self, from: data) else {return []}
        return contacts
    }
    
    func fetchContactsFromFile() -> [Contact] {
        guard let data = try? Data(contentsOf: archiveUrl) else {return []}
        guard let contacts = try? PropertyListDecoder().decode([Contact].self, from: data) else {return []}
        return contacts
    }
    
    func saveContacts(with contact: Contact) {
        var contacts = fetchContacts()
        contacts.append(contact)
        guard let data = try? JSONEncoder().encode(contacts) else {return}
        userDefaults.set(data, forKey: contactKey)
    }
    
    func saveContactsFromFile(with contact: Contact) {
        var contacts = fetchContactsFromFile()
        contacts.append(contact)
        guard let data = try? PropertyListEncoder().encode(contacts) else {return}
        try? data.write(to: archiveUrl, options: .noFileProtection)
    }
    
    func deleteContact(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
        guard let data = try? JSONEncoder().encode(contacts) else {return}
        userDefaults.set(data, forKey: contactKey)
    }
    
    func deleteContactFromFile(at index: Int) {
        var contacts = fetchContactsFromFile()
        contacts.remove(at: index)
        guard let data = try? PropertyListEncoder().encode(contacts) else {return}
        try? data.write(to: archiveUrl, options: .noFileProtection)
    }
}
