//
//  HomeScreen.swift
//  M6_L8_Task1
//
//  Created by Bekhruz Hakmirzaev on 06/12/22.
//

import SwiftUI
import Firebase

struct HomeScreen: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var database = RealtimeStore()
    @State var isLoading = false
    
    func doSignOut(){
        isLoading = true
        if SessionStore().signOut() {
            session.listen()
            isLoading = false
        }
    }
    
    func apiContacts(){
        isLoading = true
        database.loadContacts(completion: {
            isLoading = false
        })
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(database.items, id: \.self) { item in
                        ContactCell(contact: item)
                    }
                }.listStyle(PlainListStyle())
                if isLoading {
                    ProgressView()
                }
            }.onAppear{
                apiContacts()
            }
                .navigationBarItems(trailing: HStack{
                    NavigationLink(destination: AddContactScreen(), label: {
                        Image(systemName: "text.badge.plus").foregroundColor(.black)
                    })
                    Button(action: {
                        doSignOut()
                    }, label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right").foregroundColor(.black)
                    })
                })
                .navigationBarTitle("Contacts", displayMode: .inline)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().environmentObject(SessionStore())
    }
}
