//
//  SignInScreen.swift
//  M6_L8_Task1
//
//  Created by Bekhruz Hakmirzaev on 06/12/22.
//

import SwiftUI
import Firebase

struct SignInScreen: View {
    @EnvironmentObject var session: SessionStore
    @State var isLoading = false
    @State var isModel = false
    @State var email = "hakmirzaevbekhruzjon@gmail.com"
    @State var password = "123qwe"
    
    func doSignIn(){
        isLoading = true
        session.signIn(email: email, password: password, handler: {(res, err) in
            isLoading = false
            if err != nil {
                print("Check email or password")
                return
            }
            session.listen()
            print("User signed in")
        })
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Spacer()
                    Text("Welcome Back").font(.system(size: 30)).foregroundColor(.red)
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
                        doSignIn()
                    }, label: {
                        Text("Sign In").foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: 45)
                            .background(.red).cornerRadius(25)
                    })
                    Spacer()
                    HStack{
                        Text("Don't have an account?")
                        Button(action: {
                            isModel = true
                        }, label: {
                            Text("Sign Up").foregroundColor(.red)
                        }).sheet(isPresented: $isModel, content: {
                            SignUpScreen()
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

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
