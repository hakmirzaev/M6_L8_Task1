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
    @State var isLoading = false
    func doSignOut(){
        isLoading = true
        if SessionStore().signOut() {
            session.listen()
            isLoading = false
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                if let email = session.session?.email {
                    Text("Welcome \(email)")
                }
                if isLoading {
                    ProgressView()
                }
            }
                .navigationBarItems(trailing: HStack{
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "text.badge.plus").foregroundColor(.black)
                    })
                    Button(action: {
                        doSignOut()
                    }, label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right").foregroundColor(.black)
                    })
                })
                .navigationBarTitle("Posts", displayMode: .inline)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
