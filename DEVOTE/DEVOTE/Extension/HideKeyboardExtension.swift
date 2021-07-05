//
//  HideKeyboardExtension.swift
//  DEVOTE
//
//  Created by D Naung Latt on 02/07/2021.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
