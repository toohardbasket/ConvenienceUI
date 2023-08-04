//
//  ErrorAlertModifier.swift
//  
//
//  Created by Evan Sunley James on 4/08/23.
//

import SwiftUI

extension View {
    public func errorAlert(isPresented: Binding<Bool>, error: Binding<Error?>) -> some View {
        return modifier(ErrorAlert(isPresented: isPresented, error: error))
    }
}

struct ErrorAlert: ViewModifier {
    
    @Binding var isPresented: Bool
    @Binding var error: Error?
    
    func body(content: Content) -> some View {
        return content
            .alert("Error", isPresented: $isPresented, actions: {
                // noop
            }, message: {
                Text(error?.localizedDescription ?? "Something went wrong.")
            })
    }
}
