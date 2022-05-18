//
//  ContactCell.swift
//  ContactsAppSwiftUI
//
//  Created by elena on 17.05.2022.
//

import SwiftUI

struct ContactCell: View {
    var contact: Contact

    var body: some View {
        VStack(alignment: .leading) {
            Text(contact.firstName)
                .font(.headline)
            Text(contact.lastName)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell(contact: Contact.tempData.first!)
    }
}
