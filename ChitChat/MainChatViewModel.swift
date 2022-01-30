//
//  MainChatViewModel.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 26/1/2565 BE.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
class MainChatViewModel: ObservableObject {
    @Published var isCurrentUserLoggedOut = false
    @Published var recentMessages = [RecentMessage]()
    @Published var host: User?
    @Published var errorMessage = "No error ja"
    init() {
        fetchAllData()
    }
    
    func fetchAllData() {
        recentMessages = [RecentMessage(email: "one@a.com", message: "one ja"),
                          RecentMessage(email: "two@a.com", message: "two ja"),
                          RecentMessage(email: "three@a.com", message: "three ja"),
                          RecentMessage(email: "four@a.com", message: "four ja")]
        fetchHost()
    }
    
    func fetchHost() {
        errorMessage = "1111"
        if let uid = FirebaseManager.shared.auth.currentUser?.uid {
            FirebaseManager.shared.firestore
                .collection("users")
                .document(uid)
                .getDocument{ [weak self] snapshot, error in
                    if let error = error {
                        self?.errorMessage = "Failed to fetch current user: \(error)"
                        return
                    }
                    self?.host = try? snapshot?.data(as: User.self)
                    self?.errorMessage = "Success to fetch current user"
                }
        }
    }
    func handleSignout() {
        try? FirebaseManager.shared.auth.signOut()
        isCurrentUserLoggedOut.toggle()
        print("handle sign out")
    }
}
struct User: Codable, Identifiable {
    @DocumentID var id: String?
    let uid, profileImageUrl, email: String
}
