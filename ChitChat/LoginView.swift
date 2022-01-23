//
//  LoginView.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 22/1/2565 BE.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct LoginView: View {
    @State var isLoginMode = false
    
    @State var image: Image? = nil
    @State var showCaptureImageView = false
    
    @State var email = ""
    @State var password = ""
    @State var loginStatusMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    pickerView
                    if !isLoginMode {
                        imagePicker
                    }
                    textField
                    loginSignupButton
                }.padding()

                Text(self.loginStatusMessage)
                    .foregroundColor(.teal)
                if (showCaptureImageView) {
                  CaptureImageView(isShown: $showCaptureImageView, image: $image)
                }
            }
            .navigationTitle(isLoginMode ? "Login": "Signup")
            .background(Color.init(white: 0, opacity: 0.05))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    init() {
        FirebaseApp.configure()
    }
}
extension LoginView {
    func buttonDidClick() {
        if isLoginMode {
            loginUser()
        } else {
            createNewAccount()
        }
    }
    
    func loginUser() {
        FirebaseAuth.Auth
            .auth()
            .signIn(withEmail: email, password: password, completion: loginHandler)
    }
    func createNewAccount() {
        FirebaseAuth.Auth
            .auth()
            .createUser(withEmail: email, password: password, completion: loginHandler)
    }
    
    func loginHandler(result: AuthDataResult?, error: Error?) {
        if let error = error {
            loginStatusMessage = "Failed to login user: \(error)"
            return
        }
        loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        
    }
}
