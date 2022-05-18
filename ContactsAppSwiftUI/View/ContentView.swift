//
//  ContentView.swift
//  ContactsAppSwiftUI
//
//  Created by elena on 17.05.2022.
//

import SwiftUI

struct ContentView: View {

    @State private var contactArray: [Contact] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(0..<contactArray.count, id: \.self){ index in
                    ContactCell(contact: contactArray[index])
                        .swipeActions {
                            Button {
                                DataBaseHelper.shared.deleteContact(contact: contactArray[index])
                                contactArray.remove(at: index) //Удалить
                            } label: {
                                Text("Удалить")
                            }
                            .tint(.red)
                        }
                        .swipeActions {
                            Button {
                                openAlert(isAdd: false, index: index)
                            } label: {
                                Text("Изменить")
                            }
                            .tint(.indigo)
                        }
                }
            }
            .navigationTitle("Контакты")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        openAlert(isAdd: true)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                contactArray = DataBaseHelper.shared.getAllContacts()
            }
        }
    }
}

extension ContentView {
    func openAlert(isAdd: Bool, index: Int = 0) {

        let alertController = UIAlertController(
            title: isAdd ? "Добавить контакт" : "Изменить контакт",
            message: isAdd ? "Пожалуйста введите контактные данные" : "Пожалуйста измените контактные данные",
            preferredStyle: .alert)


        alertController.addTextField { firstNameField in
            firstNameField.placeholder = isAdd ? "Введите имя" : contactArray[index].firstName
        }
        alertController.addTextField { lastNameField in
            lastNameField.placeholder = isAdd ? "Введите фамилию" : contactArray[index].lastName
        }

        let save = UIAlertAction(title: isAdd ? "Сохранить" : "Изменить", style: .default) { _ in
            if let firstName = alertController.textFields?.first?.text,
               let lastName = alertController.textFields?[1].text{
                let contact = Contact(firstName: firstName, lastName: lastName)

                if isAdd {
                    DataBaseHelper.shared.addContact(contact: contact) //Realm add
                    contactArray.append(contact) //Добавить
                } else {
                    DataBaseHelper.shared.updateContact(oldContact: contactArray[index], newContact: contact)
                    contactArray[index] = contact //Изменить

                }

            }
        }

        alertController.addAction(save)

        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
