//
//  LoginView.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 22/1/2565 BE.
//

import SwiftUI
//import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift
//import FirebaseStorage
//import FirebaseFirestore

struct LoginView: View {
    let didSuccessLogin: (() -> ())
    
    @State var isLoginMode = false
    
    @State var image: UIImage? = nil
    @State var showCaptureImageView = false
    
    @State var email = ""
    @State var password = ""
    @State var loginStatusMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
//                    pickerView
                    if !isLoginMode {
                        imagePicker
                    }
                    textField
                    loginSignupButton
                    Button {
                        isLoginMode = !isLoginMode
                    } label: {
                        Text(isLoginMode ? "Create account?": "Login?")
                    }

                    Text(self.loginStatusMessage)
                        .foregroundColor(.teal)
                    if (showCaptureImageView) {
                      CaptureImageView(isShown: $showCaptureImageView, image: $image)
                    }
                }.padding()
            }
            .navigationTitle(isLoginMode ? "Login": "Signup")
            .background(Color.init(white: 0, opacity: 0.05))
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
            
    }
    
//    init() {
//        FirebaseApp.configure()
//    }
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
        FirebaseManager.shared.auth
            .signIn(withEmail: email, password: password, completion: loginHandler)
    }
    func createNewAccount() {
        guard let _ = image else {
            loginStatusMessage = "Please select image"
            return
        }
        FirebaseManager.shared.auth
            .createUser(withEmail: email, password: password, completion: {result, error in
                self.loginHandler(result, error)
                self.saveImage()
            })
    }
    
    func loginHandler(_ result: AuthDataResult?, _ error: Error?) {
        if let error = error {
            loginStatusMessage = "Failed to login user: \(error)"
            return
        }
        onLoginSuccess()
    }
    
    func onLoginSuccess() {
        loginStatusMessage = "Successfully logged in as user: \(FirebaseManager.shared.auth.currentUser?.uid ?? "")"
        didSuccessLogin()
    }

//TODO: - CallBack hell needs await to solve
    func saveImage() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid,
                let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                loginStatusMessage = "Failed to push image to Storage: \(error)"
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error {
                    loginStatusMessage = "Failed to download image from Storage: \(error)"
                    return
                }
                if let url = url {
                    storeUserInformation(imageProfileUrl: url, uid)
                }
            }
        }
    }
    
    func storeUserInformation(imageProfileUrl: URL, _ uid: String) {
        
        let data = User(uid: uid,
                        profileImageUrl: imageProfileUrl.absoluteString,
                        email: email)
        
        do {
            try FirebaseManager.shared.firestore
                .collection("users")
                .document(uid)
                .setData(from: data)
            
            onLoginSuccess()
          } catch {
              loginStatusMessage = "Failed to storeUserInformation: \(error)"
          }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView {}
    }
}
