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
    
    let recipientEmail: String
    let recipientUid: String
    
    deinit {
        print("ChatLogViewModel deinit")
    }
    
    init(_ recipientEmail: String, _ recipientUid: String) {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
//        logs = [Log(fromId: uid, toId: "cccc", text: "111111"),
//                Log(fromId: uid, toId: "cccc", text: " 2222222222"),
//                Log(fromId: "cccc", toId: uid, text: "33333")]
        self.recipientEmail = recipientEmail
        self.recipientUid = recipientUid
        fetchLog()
    }
    
    func fetchLog() {
        
    }
    
    func sendButtonDidClick() {
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
                    
                    self?.errorMessage = ""
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
    
    struct Log: Codable, Identifiable {
        @DocumentID var id: String?
        let fromId, toId, text: String
        let timestamp: Date
    }
}
