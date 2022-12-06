//
//  SignUpScreen.swift
//  M6_L8_Task1
//
//  Created by Bekhruz Hakmirzaev on 06/12/22.
//

import SwiftUI
import Firebase

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var session: SessionStore
    @State var isLoading = false
    @State var fullname = ""
    @State var email = ""
    @State var password = ""
    
    func doSignUp(){
        isLoading = true
        session.signUp(email: email, password: password, handler: {(res, err) in
            isLoading = false
            if err != nil {
                print("User not created")
                return
            }
            print("User created")
            self.presentation.wrappedValue.dismiss()
        })
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Spacer()
                    Text("Create your account").font(.system(size: 30)).foregroundColor(.red)
                    TextField("Fullname", text: $fullname)
                        .padding(.leading, 15)
                        .frame(height: 45)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(25)
                    TextField("Email", text: $email)
                        .padding(.leading, 15)
                        .frame(height: 45)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(25)
                    SecureField("Password", text: $password)
                        .padding(.leading, 15)
                        .frame(height: 45)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(25)
                    Button(action: {
                        doSignUp()
                    }, label: {
                        Text("Sign Up").foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: 45)
                            .background(.red).cornerRadius(25)
                    })
                    Spacer()
                    HStack{
                        Text("Already have an account?")
                        Button(action: {
                            presentation.wrappedValue.dismiss()
                        }, label: {
                            Text("Sign In").foregroundColor(.red)
                        })
                    }
                }.padding()
                if isLoading {
                    ProgressView()
                }
            }
        }
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
