//
//  CaptureImageView.swift
//  ChitChat
//
//  Created by Siroratt Suntronsuk on 22/1/2565 BE.
//

import Foundation
import UIKit
import SwiftUI
struct CaptureImageView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    
    func makeCoordinator() -> AnnCoordinator {
      return AnnCoordinator(isShown: $isShown, image: $image) //#1
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController() //#2
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
//        #3
    }
}

