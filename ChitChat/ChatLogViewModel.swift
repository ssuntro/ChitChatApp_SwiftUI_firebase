//
//  ChatLogViewModel.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 30/1/2565 BE.
//

import Foundation
class ChatLogViewModel: ObservableObject {
    @Published var errorMessage = "errorMessage"
    @Published var logs = [Log]()
    @Published var chatText = ""
    
    deinit {
        print("ChatLogViewModel deinit")
    }
    
    init() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        logs = [Log(fromId: uid, toId: "cccc", text: "111111"),
                Log(fromId: uid, toId: "cccc", text: " 2222222222"),
                Log(fromId: "cccc", toId: uid, text: "33333")]
    }
    
    
    struct Log: Identifiable {
        var id: String? { fromId + toId + text + timestamp.description }
        let fromId, toId, text: String
        let timestamp = Date()
    }
}
