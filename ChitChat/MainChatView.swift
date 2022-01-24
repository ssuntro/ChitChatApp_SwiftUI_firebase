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
                                cellDidClick()
                            } label: {
                                cell
                            }
                            Divider().padding(.vertical, 8)
                        }.padding(.horizontal)
                    }
                }.background(Color.brown)
            }
            .navigationBarHidden(true)
            .overlay(alignment: .bottom) { newMessageButton }
        }.foregroundColor(.secondary)
    }
    
    func newMessageButtonDidClick() {
        
    }
    
    func gearButtonDidClick() {
        
    }
    func cellDidClick() {
        
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
