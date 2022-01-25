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
                tableView
                NavigationLink(isActive: $shouldNavigateToChatLogView) {
                    ChatLogView()
                } label: {
                    Text("")
                }

            }
            .overlay(alignment: .bottom) { newMessageButton }
            .navigationBarHidden(true)
        }.foregroundColor(.secondary)
    }
    
    @State var shouldShowNewMessageScreen = false
    func newMessageButtonDidClick() {
        shouldShowNewMessageScreen.toggle()
    }
    
    @State var shouldShowLogOutOptions = false
    func gearButtonDidClick() {
        shouldShowLogOutOptions.toggle()
    }
    
    @State var shouldNavigateToChatLogView = false
    func cellDidClick() {
        shouldNavigateToChatLogView.toggle()
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
