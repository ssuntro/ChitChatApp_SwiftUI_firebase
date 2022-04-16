//
//  MainChatViewModel.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 26/1/2565 BE.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift //for ListenerRegistration
import FirebaseFirestore //for ListenerRegistration
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
        fetchRecentMessage()
//        recentMessages = [
//            RecentMessage(email: "x@x.com", message: "x ja", uid: "gDXrDU3Re5bP6n9X8WxNftFvPPp2"),
//            RecentMessage(email: "b@b.com", message: "two ja", uid: "5G5qNpugF4Yfko8bR2wlk4s3n7n2")]
    }
    var recentMessagesListener: ListenerRegistration?
    func fetchRecentMessage() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        recentMessages.removeAll()
        
        recentMessagesListener?.remove()
        recentMessagesListener = FirebaseManager.shared.firestore
            .collection("recentMessages")
            .document(uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { [weak self] snapshot, error in
                if let _ = error  {
                    self?.errorMessage = "fetch recentMessages"
                    return
                }
                snapshot?.documentChanges.forEach({ change in
                    let friendUid = change.document.documentID
                    if let index = self?.recentMessages.firstIndex(where: { entry in
                        entry.id == friendUid
                    }) {
                        self?.recentMessages.remove(at: index)
                    }
                    
                    if let data = try? change.document.data(as: RecentMessage.self) {
                        self?.recentMessages.insert(data, at: 0)
//                        self?.recentMessages.append(data)
                    }
                })
            }
    }
    
    
    func fetchHost() {
        errorMessage = "no error"
        if let uid = FirebaseManager.shared.auth.currentUser?.uid {
            FirebaseManager.shared.firestore
                .collection("users")
                .document(uid)
                .getDocument{ [weak self] snapshot, error in
                    if let error = error {
                        self?.errorMessage = "Failed to fetch current user: \(error)"
                        return
                    }
//TODO: - centralise host var at FirebaseManager
                    self?.host = try? snapshot?.data(as: User.self)
                    FirebaseManager.shared.host = try? snapshot?.data(as: User.self)
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
        activeFriendImageUrl = friend.profileImageUrl
    }
    
    @Published var shouldNavigateToChatLogView = false
//TODO: - reduce human error by creating using recentMessage instance.
    @Published var activeFriendEmail: String?
    @Published var activeFriendUid: String?
    @Published var activeFriendImageUrl: String?
    
    func cellDidClick(_ recentMessage: RecentMessage) {
        shouldNavigateToChatLogView.toggle()
        activeFriendEmail = recentMessage.email
        activeFriendUid = recentMessage.uid
        activeFriendImageUrl = recentMessage.imageUrl
    }
}
struct User: Codable, Identifiable {
    @DocumentID var id: String?
    let uid, profileImageUrl, email: String
}

struct RecentMessage: Codable, Identifiable {
    @DocumentID var id: String?

    let imageUrl: String
    //= "https://i.guim.co.uk/img/media/fe1e34da640c5c56ed16f76ce6f994fa9343d09d/0_174_3408_2046/master/3408.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=67773a9d419786091c958b2ad08eae5e"
    let email: String
    let message: String
    let timestamp: Date// = "6 Days ago"
    let uid: String

    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
