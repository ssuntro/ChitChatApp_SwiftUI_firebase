//
//  CreateNewMessageView.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 24/1/2565 BE.
//

import SwiftUI

struct CreateNewMessageView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Text("Hello, World!")
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
            
        }
        
    }
}

struct CreateNewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewMessageView()
    }
}
