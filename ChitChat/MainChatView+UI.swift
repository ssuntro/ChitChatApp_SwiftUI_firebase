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
            CreateNewMessageView()
        }
    }
    
    var tableView: some View {
        ScrollView {
            ForEach(recentMessages) { message in
                VStack {
                    Button {
                        cellDidClick()
                    } label: {
                        cell
                    }
                    Divider().padding(.vertical, 8)
                }.padding(.horizontal)
            }
        }.background(Color.brown)
    }
    
    var cell: some View {
        HStack {
            WebImage(url: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/chitchat-40120.appspot.com/o/O1UwxcRv6yeA1sJYDGTM2xyl8pF3?alt=media&token=cb17db7c-ee5d-455e-b586-bb86648f1cb9"))
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .cornerRadius(64)
            VStack {
                Text("usernameusernameusernameusernameusernameusername")
                    .font(.system(size: 16, weight: .bold))
                    .multilineTextAlignment(.leading)
                Text("recentMesrecentMesrecentMesrecentMesrecentMes")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Text("55 days ago")
                .font(.system(size: 14, weight: .semibold))
        }
    }
    
    var userPanel: some View {
        HStack(spacing: 16) {
            WebImage(url: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/chitchat-40120.appspot.com/o/O1UwxcRv6yeA1sJYDGTM2xyl8pF3?alt=media&token=cb17db7c-ee5d-455e-b586-bb86648f1cb9"))
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipped()
                .cornerRadius(50)
                .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color(.label), lineWidth: 1)
                )
                .shadow(radius: 5)
            Text("a@a.com")
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
                  buttons: [
                .destructive(Text("Sign Out"), action: {
                    print("handle sign out")
                }),
                    .cancel()
            ])
        }
    }
}
