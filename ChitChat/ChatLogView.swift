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
        Text("ChatLogView")
            .navigationTitle(Text(recipientEmail))
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatLogView(recipientEmail: "asbcds")
        }
        
    }
}
