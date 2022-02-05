//
//  ChatLogViewModel.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 30/1/2565 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatLogViewModel: ObservableObject {
    @Published var errorMessage = "errorMessage"
    @Published var logs = [Log]()
    @Published var chatText = ""
    @Published var count = 0
    
    let recipientEmail: String
    let recipientUid: String
    let recipientImageUrl: String
    var firestoreListener: ListenerRegistration?
    
    deinit {
        print("ChatLogViewModel deinit")
    }
    
    init(_ recipientEmail: String,
         _ recipientUid: String,
         _ recipientImageUrl: String) {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
//        logs = [Log(fromId: uid, toId: "cccc", text: "111111"),
//                Log(fromId: uid, toId: "cccc", text: " 2222222222"),
//                Log(fromId: "cccc", toId: uid, text: "33333")]
        self.recipientEmail = recipientEmail
        self.recipientUid = recipientUid
        self.recipientImageUrl = recipientImageUrl
        fetchLog()
    }
    
    func fetchLog() {
        if let fromId = FirebaseManager.shared.auth.currentUser?.uid {
            firestoreListener?.remove()
            firestoreListener = FirebaseManager.shared.firestore
                .collection("messages")
                .document(fromId)
                .collection(recipientUid)
                .order(by: "timestamp")
                .addSnapshotListener { [weak self] snapshot, error in
                    if let error = error {
                        self?.errorMessage = "Failed to retrieve message into host Firestore: \(error)"
                        return
                    }
                    
                    snapshot?.documentChanges
                        .forEach({ change in
                            if change.type == .added,
                               let log = try? change.document.data(as: Log.self) {
                                self?.logs.append(log)
                            }
                        })
                    DispatchQueue.main.async {
                        self?.count += 1
                    }
                }
        }
    }
    
    func sendButtonDidClick() {
        persistChatLog()
        updateRecentMessage()
    }
    
    func updateRecentMessage() {
        guard let host = FirebaseManager.shared.host else { return }
//        B -> z
        FirebaseManager.shared.firestore
            .collection("recentMessages")
            .document(host.uid)
            .collection("messages")
            .document(recipientUid)
            .setData(["imageUrl": recipientImageUrl,
                              "email": recipientEmail,
                              "message": chatText,
                              "timestamp": Timestamp(),
                              "uid": recipientUid]) { [weak self] err in
                self?.errorMessage = err?.localizedDescription ?? "no error"
            }
        
        //MainView of Z wil fetch
        FirebaseManager.shared.firestore
            .collection("recentMessages")
            .document(recipientUid)
            .collection("messages")
            .document(host.uid)
            .setData(["imageUrl": host.profileImageUrl,
                      "email": host.email,
                      "message": chatText,
                      "timestamp": Timestamp(),
                      "uid": host.uid]) { [weak self] err in
                self?.errorMessage = err?.localizedDescription ?? "no error"
            }
    }
    
    func persistChatLog() {
        if let fromId = FirebaseManager.shared.auth.currentUser?.uid {
            let messsage = Log(fromId: fromId,
                               toId: recipientUid,
                               text: chatText,
                               timestamp: Date())
            try? FirebaseManager.shared.firestore
                .collection("messages")
                .document(fromId)
                .collection(recipientUid)
                .document()
                .setData(from: messsage) { [weak self] error in
                    if let error = error {
                        self?.errorMessage = "Failed to save message into host Firestore: \(error)"
                        return
                    }
                    
                    self?.errorMessage = "no error"
                    self?.chatText = ""
                    
                }
            
            //save in messages.toId.fromId = message
            try? FirebaseManager.shared.firestore
                .collection("messages")
                .document(recipientUid)
                .collection(fromId)
                .document()
                .setData(from: messsage) { [weak self] error in
                    if let error = error {
                        self?.errorMessage = "Failed to save message into recipient Firestore: \(error)"
                        return
                    }
                }
        }
    }
}
struct Log: Codable, Identifiable {
    @DocumentID var id: String?
    let fromId, toId, text: String
    let timestamp: Date
}
