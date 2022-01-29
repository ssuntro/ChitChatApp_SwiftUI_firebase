//
//  MainChatViewModel.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 26/1/2565 BE.
//

import Foundation
import SwiftUI
class MainChatViewModel: ObservableObject {
    @Published var isCurrentUserLoggedOut = false
    @Published var recentMessages = [RecentMessage]()
    init() {
        recentMessages = [RecentMessage(email: "one@a.com", lastestLog: "one ja"),
                          RecentMessage(email: "two@a.com", lastestLog: "two ja"),
                          RecentMessage(email: "three@a.com", lastestLog: "three ja"),
                          RecentMessage(email: "four@a.com", lastestLog: "four ja")]
    }
    func handleSignout() {
        try? FirebaseManager.shared.auth.signOut()
        isCurrentUserLoggedOut.toggle()
        print("handle sign out")
    }
}
