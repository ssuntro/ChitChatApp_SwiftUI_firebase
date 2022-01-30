//
//  CreateNewMessageViewModel.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 30/1/2565 BE.
//

import Foundation

//TODO: - should be inside FirebaseManager.shared
import FirebaseFirestoreSwift

class CreateNewMessageViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var users = [User]()
    
    init() {
        FirebaseManager.shared.firestore
            .collection("users")
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    self?.errorMessage = "Failed to fetch users: \(error)"
                    return
                }
                snapshot?.documents.forEach({ entry in
                    if let user = try? entry.data(as: User.self),
                        user.uid != (FirebaseManager.shared.auth.currentUser?.uid ?? "") {
                        self?.users.append(user)
                    }
                })
            }
    }
}
