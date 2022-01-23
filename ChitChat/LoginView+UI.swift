//
//  LoginView+UI.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 23/1/2565 BE.
//

import SwiftUI

//MARK: - UI
extension LoginView {
    var pickerView: some View {
        Picker(selection: $isLoginMode,
               label: Text("Picker")) {
            Text("Login")
                .tag(true)
            Text("Signup")
                .tag(false)
        }.pickerStyle(SegmentedPickerStyle())
    }

    var imagePicker: some View {
        Group {
        Button {
            self.showCaptureImageView.toggle()
        } label: {
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
//                        .padding()
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.fill")
                        .font(.system(size: 64))
                        .padding()
                        .foregroundColor(Color(.label))
                }


            }
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
        }
        }
    }
    
    var textField: some View {
        Group {
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
        }
        .padding(12)
        .background(Color.white)
    }
    
    var loginSignupButton: some View {
        Button {
            buttonDidClick()
        } label: {
            Spacer()
            Text(isLoginMode ? "Log In" : "Sign up")
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .font(.system(size: 14, weight: .semibold))
            Spacer()
        }.background(.blue)
    }
}
