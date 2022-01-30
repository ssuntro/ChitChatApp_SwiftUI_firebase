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
    
    
    deinit {
        print("MainChatViewModel deinit")
    }
    
    init() {
        fetchAllData()
    }
    
    func fetchAllData() {
        fetchHost()
        recentMessages = [//RecentMessage(email: "z@z.com", message: "tmp ja", friendUid: "jvGKf8PeXqgG7XnPfWSGaHkU9zn1")],
                        RecentMessage(email: "b@b.com", message: "two ja", friendUid: "5G5qNpugF4Yfko8bR2wlk4s3n7n2")] /*,
                          RecentMessage(email: "three@a.com", message: "three ja"),
                          RecentMessage(email: "four@a.com", message: "four ja")]*/
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
        } else {
            isCurrentUserLoggedOut.toggle()
        }
    }
    
    func handleSignout() {
        try? FirebaseManager.shared.auth.signOut()
        isCurrentUserLoggedOut.toggle()
        print("handle sign out")
    }
    
    func didSelectSearchFriends(_ friend: User) {
        shouldNavigateToChatLogView.toggle()
        activeFriendEmail = friend.email
        activeFriendUid = friend.uid
    }
    
    @Published var shouldNavigateToChatLogView = false
    @Published var activeFriendEmail: String?
    @Published var activeFriendUid: String?
    
    func cellDidClick(_ recentMessage: RecentMessage) {
        shouldNavigateToChatLogView.toggle()
        activeFriendEmail = recentMessage.email
        activeFriendUid = recentMessage.friendUid
    }
}
struct User: Codable, Identifiable {
    @DocumentID var id: String?
    let uid, profileImageUrl, email: String
}
