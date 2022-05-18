//
//  Contact.swift
//  ContactsAppSwiftUI
//
//  Created by elena on 17.05.2022.
//

import RealmSwift

class Contact: Object {
//    var id = UUID().uuidString
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var firstName = ""
    @Persisted var lastName = ""


    convenience init(firstName: String, lastName: String) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
    }

    static var tempData: [Contact] = [
        Contact(firstName: "", lastName: ""),
        Contact(firstName: "", lastName: "")
    ]
}
