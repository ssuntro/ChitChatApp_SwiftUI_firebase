//
//  CreateNewMessageView+UI.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 30/1/2565 BE.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

extension CreateNewMessageView {
    func cell(_ user: User) -> some View {
        Button {
            print("cell did click")
        } label: {
            VStack {
                HStack {
                    WebImage(url: URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .cornerRadius(10)
                    Text(user.email)
                        .font(.system(size: 16, weight: .bold))
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                }.padding([.horizontal, .top])
                Divider().foregroundColor(.clear)
            }
        }
    }
}
