//
//  FirebaseManager.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 23/1/2565 BE.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct FirebaseManager {
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    var host: User?
    
    static var shared = FirebaseManager()
    private init() {
        FirebaseApp.configure()
        auth = Auth.auth()
        storage = Storage.storage()
        firestore = Firestore.firestore()
    }
}
