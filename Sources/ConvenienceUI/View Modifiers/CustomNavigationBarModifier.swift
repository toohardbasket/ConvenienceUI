//
//  CustomNavigationBarModifier.swift
//
//
//  Created by Evan Sunley James on 4/08/23.
//

import SwiftUI

extension View {
    public func customNavigationBar<T: ToolbarContent, B: View>(isRoot: Bool, backButton: @escaping () -> B, toolbarContent: @escaping () -> T) -> some View {
        return modifier(CustomNavigationBar(isRoot: isRoot, backButton: backButton, toolbarContent: toolbarContent))
    }
    
    public func customNavigationBar<B: View>(isRoot: Bool, backButton: @escaping () -> B) -> some View{
        return modifier(CustomNavigationBar(isRoot: isRoot, backButton: backButton, toolbarContent: {
            ToolbarItemGroup {
                EmptyView()
            }
        }))
    }
    
    public func customNavigationBar<T: ToolbarContent>(isRoot: Bool, toolbarContent: @escaping () -> T) -> some View{
        return modifier(CustomNavigationBar(isRoot: isRoot, backButton: {
            EmptyView()
        }, toolbarContent: toolbarContent))
    }
}

public struct CustomNavigationBar<T: ToolbarContent, B: View>: ViewModifier {
    
    public var isRoot: Bool
    public var backButton: () -> B
    public var toolbarContent: () -> T
    
    public init(isRoot: Bool, backButton: @escaping () -> B, toolbarContent: @escaping () -> T) {
        self.isRoot = isRoot
        self.backButton = backButton
        self.toolbarContent = toolbarContent
    }
    
    public func body(content: Content) -> some View {
        
        let backButton = backButton()
        
        return content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if !isRoot,
                   B.self != EmptyView.self {
                    #if os(iOS)
                    ToolbarItem(placement: .navigationBarLeading) {
                        backButton
                    }
                    #elseif os(macOS)
                    ToolbarItem(placement: .navigation) {
                        backButton
                    }
                    #endif
                }
                toolbarContent()
            }
            #if os(iOS)
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            #elseif os(macOS)
            .toolbarBackground(.hidden, for: .windowToolbar)
            #endif
    }
}
