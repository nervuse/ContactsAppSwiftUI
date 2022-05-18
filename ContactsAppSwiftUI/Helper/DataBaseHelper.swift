//
//  DataBaseHelper.swift
//  ContactsAppSwiftUI
//
//  Created by elena on 18.05.2022.
//

import RealmSwift
import Foundation

/// Singleton class - Design Pattern

class DataBaseHelper {
    static let shared = DataBaseHelper()

    private var realm = try! Realm()

    init() {
        print(dataBaseURL())
    }

    func dataBaseURL() -> URL? {
        return realm.configuration.fileURL
    }

    func addContact(contact: Contact) {
        try? realm.write({
            realm.add(contact)
        })
    }

    func updateContact(oldContact: Contact, newContact: Contact) {
        try? realm.write ({
            oldContact.firstName = newContact.firstName
            oldContact.lastName = newContact.lastName
        })
    }

    func deleteContact(contact: Contact) {
        try? realm.write({
            realm.delete(contact)
        })
    }

    func getAllContacts() -> [Contact] {
        return Array(realm.objects(Contact.self))
    }
}
