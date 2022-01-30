//
//  CreateNewMessageView.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 24/1/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreateNewMessageView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm = CreateNewMessageViewModel()
    let onSelectFriend: (User) -> ()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(vm.errorMessage)
                ScrollView {
                    ForEach(vm.users) {user in
                        cell(user)
                    }
                }.background(Color.brown)
            }
            .navigationTitle("New Message")
            .toolbar {
                ToolbarItemGroup(placement: .navigation) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            
        }.foregroundColor(.secondary)
        
    }
}

struct CreateNewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewMessageView(onSelectFriend: { _ in })
    }
}
