//
//  MainChatView.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 23/1/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainChatView: View {
    var body: some View {
        NavigationView {
            VStack {
                userPanel
            ScrollView {
                ForEach(recentMessages) { message in
                    VStack {
                        Button {

                        } label: {
                            Text("entry")
                        }
                    }
                }
            }
            }
            .navigationBarHidden(true)
        }
        
    }
    
    var userPanel: some View {
        HStack(spacing: 16) {
            WebImage(url: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/chitchat-40120.appspot.com/o/O1UwxcRv6yeA1sJYDGTM2xyl8pF3?alt=media&token=cb17db7c-ee5d-455e-b586-bb86648f1cb9"))
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipped()
                .cornerRadius(50)
                .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color(.label), lineWidth: 1)
                )
                .shadow(radius: 5)
            Text("a@a.com")
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Button {
                print("click")
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
            }
        }.padding()
    }
}

struct RecentMessage: Identifiable {
    var id: String {
        return email
    }
    
    let image = "https://i.guim.co.uk/img/media/fe1e34da640c5c56ed16f76ce6f994fa9343d09d/0_174_3408_2046/master/3408.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=67773a9d419786091c958b2ad08eae5e"
    let email: String
    let text: String
    let timestamp = "6 Days ago"
}

let recentMessages = [RecentMessage(email: "one@a.com", text: "one ja"),
                      RecentMessage(email: "two@a.com", text: "two ja"),
                      RecentMessage(email: "one@a.com", text: "one ja"),
                      RecentMessage(email: "two@a.com", text: "two ja")]

struct MainChatView_Previews: PreviewProvider {
    static var previews: some View {
        MainChatView()
    }
}
