//
//  ScenePhaseActionModifier.swift
//  
//
//  Created by Evan Sunley James on 4/08/23.
//

import SwiftUI

@available(iOS 17.0, *)
extension View {
    func scenePhaseAction(active: ((_ oldValue: ScenePhase) -> Void)? = nil,
                                inactive: ((_ oldValue: ScenePhase) -> Void)? = nil,
                                background: ((_ oldValue: ScenePhase) -> Void)? = nil) -> some View {
        return modifier(ScenePhaseAction(active: active, inactive: inactive, background: background))
    }
}

@available(iOS 17.0, *)
struct ScenePhaseAction: ViewModifier {

    @Environment(\.scenePhase) var scenePhase
    var active: ((ScenePhase) -> Void)?
    var inactive: ((ScenePhase) -> Void)?
    var background: ((ScenePhase) -> Void)?
    
    func body(content: Content) -> some View {
        content
        .onChange(of: scenePhase) { oldValue, newValue in
            switch newValue {
            case .background:
                background?(oldValue)
            case .inactive:
                inactive?(oldValue)
            case .active:
                active?(oldValue)
            @unknown default:
                break
            }
        }
    }
}
