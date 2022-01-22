//
//  LoginView.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 22/1/2565 BE.
//

import SwiftUI


struct LoginView: View {
    @State var isLoginMode = false
    
    @State var image: Image? = nil
    @State var showCaptureImageView = false
    
    @State var email = ""
    @State var password = ""
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    pickerView
                    if !isLoginMode {
                        imagePicker
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(Color.white)
                    

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
                    
                }.padding()
                
                if (showCaptureImageView) {
                  CaptureImageView(isShown: $showCaptureImageView, image: $image)
                }
            }
            .navigationTitle(isLoginMode ? "Login": "Signup")
            .background(Color.init(white: 0, opacity: 0.05))
        }
    }
    
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
//            imageButtonDidClick()
            self.showCaptureImageView.toggle()
        } label: {
            VStack {
                if let image = image {
                    image.resizable()
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
    
    func buttonDidClick() {
        print("signup/login button did click: \(email), \(password)")
    }
    
    func imageButtonDidClick() {
        //IBAction did not called on preview action.
        print("imageButtonDidClick")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
//        ZStack {LoginView()}
        LoginView()
        
    }
}
