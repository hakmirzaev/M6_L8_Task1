//
//  AddContactScreen.swift
//  M6_L8_Task1
//
//  Created by Bekhruz Hakmirzaev on 06/12/22.
//

import SwiftUI


struct AddContactScreen: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var database = RealtimeStore()
    @ObservedObject var storage = StorageStore()
    @State var isLoading = false
    @State var firstname = ""
    @State var lastname = ""
    @State var phone = ""
    @State var defImage = UIImage(imageLiteralResourceName: "im_picker")
    @State var pickedImage: UIImage? = nil
    @State var showImagePicker = false
    
    func addNewContact(urlString: String) {
        let contact = Contact(firstname: firstname, lastname: lastname, phone: phone, imgUrl: urlString)
        database.storeContact(contact: contact, completion: { success in
            if success {
                self.presentation.wrappedValue.dismiss()
            }
            isLoading = false
        })
    }
    
    func uploadImage(){
        isLoading = true
        storage.uploadImage(pickedImage!, completion: { downloadUrl in
            let urlString = downloadUrl!.absoluteString
            print(urlString)
            addNewContact(urlString: urlString)
        })
    }
    
    var body: some View {
        ZStack{
            VStack{
                Button(action: {
                    self.showImagePicker.toggle()
                }, label: {
                    Image(uiImage: pickedImage ?? defImage).resizable().frame(width: 100, height: 100).scaledToFit()
                }).sheet(isPresented: $showImagePicker,onDismiss: {
                    self.showImagePicker = false
                }, content: {
                    ImagePicker(image: self.$pickedImage, isShown: $showImagePicker)
                })
                TextField("Firstname", text: $firstname).frame(height: 50)
                    .padding(.leading, 10).background(.gray.opacity(0.2))
                    .cornerRadius(15)
                TextField("Lastname", text: $lastname).frame(height: 50)
                    .padding(.leading, 10).background(.gray.opacity(0.2))
                    .cornerRadius(15)
                TextField("Phone", text: $phone).frame(height: 50)
                    .padding(.leading, 10).background(.gray.opacity(0.2))
                    .cornerRadius(15)
                Button(action: {
                    uploadImage()
                }, label: {
                    Text("Add").frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundColor(.white).background(.red)
                        .cornerRadius(15)
                })
                Spacer()
                
            }.padding()
            Spacer()
            if isLoading{
                ProgressView()
            }
        }
        .navigationBarTitle("Add Contact", displayMode: .inline)
    }
}

struct AddContactScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddContactScreen()
    }
}
