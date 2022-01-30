//
//  ChatLogView.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 25/1/2565 BE.
//

import SwiftUI

struct ChatLogView: View {
    init(recipientEmail: String, recipientUid: String) {
        vm = ChatLogViewModel(recipientEmail, recipientUid)
    }
    
    var body: some View {
        VStack {
            Text(vm.errorMessage)
            if let uid = FirebaseManager.shared.auth.currentUser?.uid {
                ScrollView {
                    ForEach(vm.logs) { log in
                        cell(hostUid: uid, log)
                    }
                }
                .background(Color.brown)
                .safeAreaInset(edge: .bottom,
                               content: {
                    HStack(spacing: 16) {
                        HStack {
                            TextEditor(text: $vm.chatText)
                                .frame(height: 40)
                            Button {
                                vm.sendButtonDidClick()
                            } label: {
                                Text("SEND").foregroundColor(Color.white)
                            }
                            Spacer()

                        }
                    }.background(Color.secondary.ignoresSafeArea())
                })
            }
            
        }

        .navigationTitle(Text(vm.recipientEmail))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ObservedObject var vm: ChatLogViewModel
    
    func cell(hostUid: String, _ log: Log) -> some View {
        HStack {
            if log.fromId == hostUid {
                Spacer()
                Text(log.text)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.secondary)
                    .cornerRadius(8)
            } else {
                Text(log.text)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                Spacer()
            }
        }.padding()
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatLogView(recipientEmail: "z@z.com",
                        recipientUid: "jvGKf8PeXqgG7XnPfWSGaHkU9zn1")
        }
        
    }
}
