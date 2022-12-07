//
//  ContactCell.swift
//  M6_L8_Task1
//
//  Created by Bekhruz Hakmirzaev on 06/12/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContactCell: View {
    var contact: Contact
    var body: some View {
        ZStack{
            HStack{
                if contact.imgUrl != nil {
                    WebImage(url: URL(string: contact.imgUrl!))
                        .resizable()
                        .frame(width: 100, height: 100)
                } else {
                    Image("im_picker").resizable()
                        .frame(width: 100, height: 100)
                }
                VStack(alignment: .leading){
                    HStack(spacing: 10){
                        Text(contact.lastname!.uppercased()).fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(contact.firstname!.uppercased()).fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                    Text(contact.phone!).padding(.top, 10)
                }
            }
        }
    }
}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell(contact: Contact(firstname: "firstname", lastname: "lastname", phone: "phone", imgUrl: "imgUrl"))
    }
}
