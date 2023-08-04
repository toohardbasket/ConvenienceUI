//
//  CustomNavigationBarModifier.swift
//
//
//  Created by Evan Sunley James on 4/08/23.
//

import SwiftUI

extension View {
    func customNavigationBar<T: ToolbarContent, B: View>(isRoot: Bool, backButton: (() -> B)? = nil, toolbarContent: (() -> T)? = nil) -> some View {
        return modifier(CustomNavigationBar(isRoot: isRoot, backButton: backButton, toolbarContent: toolbarContent))
    }
}

struct CustomNavigationBar<T: ToolbarContent, B: View>: ViewModifier {
    
    @Environment(\.dismiss) private var dismiss
    var isRoot: Bool
    var backButton: (() -> B)?
    var toolbarContent: (() -> T)?
    
    func body(content: Content) -> some View {
        return content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if !isRoot,
                    let backButton = backButton {
                    ToolbarItem(placement: .navigationBarLeading) {
                        backButton()
                    }
                }
                toolbarContent?()
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
    }
}
