//
//  MainChatView+UI.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 24/1/2565 BE.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

//MARK: - UI
extension MainChatView {
    var newMessageButton: some View {
        Button {
            newMessageButtonDidClick()
        } label: {
            HStack {
                Spacer()
                Text("+ New Message").font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
        }
        .fullScreenCover(isPresented: $shouldShowNewMessageScreen) {
            CreateNewMessageView(onSelectFriend: { friend in
                vm.didSelectSearchFriends(friend) })
        }
    }
    
    var tableView: some View {
        ScrollView {
            ForEach(isOrderByRecentMessage ? vm.recentMessages: vm.recentMessages.sorted { $0.email < $1.email }) { message in
                VStack {
                    Button {
                        vm.cellDidClick(message)
                    } label: {
                        cell(message)
                    }.padding([.top, .horizontal])
                    Divider()//.padding(.vertical, 4)
                }
            }
        }.background(Color.brown)
    }
    
    func cell(_ message: RecentMessage) -> some View {
        return HStack {
            WebImage(url: URL(string: message.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
//                .cornerRadius(64)
                .cornerRadius(10)
            VStack {
                Text(message.email)
                    .font(.system(size: 16, weight: .bold))
                    .multilineTextAlignment(.leading)
                Text(message.message)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Text(message.timestamp)
                .font(.system(size: 14, weight: .semibold))
        }
    }
    
    var userPanel: some View {
        HStack(spacing: 16) {
            WebImage(url: URL(string: vm.host?.profileImageUrl ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipped()
//                .cornerRadius(50)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.label), lineWidth: 1)
                )
                .shadow(radius: 5)
            Text(vm.host?.email ?? "")
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Button {
                gearButtonDidClick()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
            }
        }
        .padding()
        .actionSheet(isPresented: $shouldShowLogOutOptions) {
            ActionSheet(title: Text("Settings"),
                  message: Text("What do you want to do?"),
                  buttons: [.destructive(Text("Sign Out"),
                                         action: { vm.handleSignout() }),
                            .cancel()])
        }
        .fullScreenCover(isPresented: $vm.isCurrentUserLoggedOut,
                         onDismiss: nil) {
            LoginView(didSuccessLogin: {
                vm.isCurrentUserLoggedOut = false
                vm.fetchAllData()
            })
        }
    }
}
