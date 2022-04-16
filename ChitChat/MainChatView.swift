//
//  MainChatView.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 23/1/2565 BE.
//

import SwiftUI

struct MainChatView: View {
    @State var isOrderByRecentMessage = true
    var body: some View {
        NavigationView {
            VStack {
                userPanel
                Text(vm.errorMessage)
                HStack {
                    Spacer()
                    Picker(selection: $isOrderByRecentMessage, label: Text("Picker here")) {
                        Text("Recent message")
                            .tag(true)
                        Text("name")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    Spacer()
                }
                tableView
                
                if let activeFriendEmail = vm.activeFriendEmail,
                   let activeFriendUid = vm.activeFriendUid,
                   let activeFriendImageUrl = vm.activeFriendImageUrl {
                    NavigationLink(isActive: $vm.shouldNavigateToChatLogView) {
                        if vm.shouldNavigateToChatLogView {
                            ChatLogView(recipientEmail: activeFriendEmail,
                                        recipientUid: activeFriendUid,
                                        recipientImageUrl: activeFriendImageUrl)
                        }
                        
                    } label: {
                        Text("")
                    }
                }

            }
            .overlay(alignment: .bottom) { newMessageButton }
            .navigationBarHidden(true)
        }
        .foregroundColor(.secondary)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
//TODO: - migrate to VM
    @State var shouldShowNewMessageScreen = false
    func newMessageButtonDidClick() {
        shouldShowNewMessageScreen.toggle()
    }

//TODO: - migrate to VM
    @State var shouldShowLogOutOptions = false
    func gearButtonDidClick() {
        shouldShowLogOutOptions.toggle()
    }
    
    @ObservedObject var vm = MainChatViewModel()
}





struct MainChatView_Previews: PreviewProvider {
    static var previews: some View {
        MainChatView()
    }
}
