//
//  ToggleButton.swift
//  
//
//  Created by Evan Sunley James on 6/08/23.
//

import SwiftUI

public struct ToggleButtonStyle<S: ShapeStyle>: ButtonStyle {
    
    @Binding var active: Bool
    var activeColor: S
    var inactiveColor: S
    
    public init(active: Binding<Bool>, activeColor: S, inactiveColor: S) {
        _active = active
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundStyle(active ? activeColor : inactiveColor)
    }
}

public struct ToggleButton<Label: View, S: ShapeStyle>: View {
    
    @Binding var active: Bool
    var activeColor: S
    var inactiveColor: S
    @ViewBuilder let label: () -> Label
    
    public init(active: Binding<Bool>, activeColor: S, inactiveColor: S, label: @escaping () -> Label) {
        _active = active
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
        self.label = label
    }
    
    public var body: some View {
        Button {
            active.toggle()
        } label: {
            label()
        }
        .buttonStyle(ToggleButtonStyle(active: $active, activeColor: activeColor, inactiveColor: inactiveColor))
    }
}

struct ToggleButton_Previews: PreviewProvider {
    @State static var active = false
    static var previews: some View {
        ToggleButton(active: $active,
                     activeColor: .black,
                     inactiveColor: .gray) {
            Text("Hello")
        }
    }
}
