//
//  RealtimeStore.swift
//  M6_L8_Task1
//
//  Created by Bekhruz Hakmirzaev on 06/12/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseDatabase

class RealtimeStore: ObservableObject {
    var ref: DatabaseReference = Database.database().reference(withPath: "contacts")
    @Published var items: [Contact] = []
    
    func storeContact(contact: Contact, completion: @escaping(_ success: Bool) -> ()) {
        var success = true
        let tobeSaved = ["firstname": contact.firstname!,"lastname": contact.lastname!,"phone": contact.phone!,"imgUrl": contact.imgUrl!]
        ref.childByAutoId().setValue(tobeSaved) { (error, ref) -> Void in
            if error != nil {
                success = false
            }
            completion(success)
        }
    }
    
    func loadContacts(completion: @escaping () -> ()) {
        ref.observe(DataEventType.value) { (snapshot) in
            self.items = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    let value = snapshot.value as? [String: AnyObject]
                    let firstname = value!["firstname"] as? String
                    let lastname = value!["lastname"] as? String
                    let phone = value!["phone"] as? String
                    let imgUrl = value!["imgUrl"] as? String
                    self.items.append(Contact(firstname: firstname, lastname: lastname, phone: phone, imgUrl: imgUrl))
                }
            }
            completion()
        }
    }
}
