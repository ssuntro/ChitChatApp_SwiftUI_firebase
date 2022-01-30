//
//  ChatLogView.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 25/1/2565 BE.
//

import SwiftUI

struct ChatLogView: View {
    let recipientEmail: String
    var body: some View {
        VStack {
            Text(vm.errorMessage)
            if let uid = FirebaseManager.shared.auth.currentUser?.uid {
                ScrollView {
                    ForEach(vm.logs) { log in
                        if log.fromId == uid {
                            HStack {
                                Spacer()
                                Text(log.text)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.secondary)
                                    .cornerRadius(8)
                            }.padding()
                        } else {
                            HStack {
                                Text(log.text)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                Spacer()
                            }.padding()
                        }
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
                                print("SEND did click")
                            } label: {
                                Text("SEND").foregroundColor(Color.white)
                            }
                            Spacer()

                        }
                    }.background(Color.secondary.ignoresSafeArea())
                })
            }
            
        }

        .navigationTitle(Text(recipientEmail))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ObservedObject var vm = ChatLogViewModel()
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatLogView(recipientEmail: "asb@cds")
        }
        
    }
}
