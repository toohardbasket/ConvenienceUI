//
//  RoundedRectBackgroundModifiers.swift
//  
//
//  Created by Evan Sunley James on 4/08/23.
//

import SwiftUI

extension View {
    public func borderedRoundedRectBackground<S: ShapeStyle>(_ style: S, _ strokeStyle: S, radius: CGFloat = 8, lineWidth: CGFloat = 10, borderInset: CGFloat = 0) -> some View {
        return modifier(BorderedRoundedRectBackground<S>(style: style, strokeStyle: strokeStyle, radius: radius, lineWidth: lineWidth, inset: borderInset))
    }
}

struct BorderedRoundedRectBackground<S: ShapeStyle>: ViewModifier {
    
    var style: S
    var strokeStyle: S
    var radius: CGFloat
    var lineWidth: CGFloat
    var inset: CGFloat
    
    func body(content: Content) -> some View {
        return content
            .roundedRectBackground(style)
            .roundedRectBorderOverlay(strokeStyle, lineWidth: lineWidth, inset: inset)
    }
}


extension View {
    public func roundedRectBackground<S: ShapeStyle>(_ style: S, radius: CGFloat = 8) -> some View {
        return modifier(RoundedRectBackground<S>(style: style, radius: radius))
    }
}

struct RoundedRectBackground<S: ShapeStyle>: ViewModifier {
    var style: S
    var radius: CGFloat
    func body(content: Content) -> some View {
        return content
            .background(
                style,
                in: RoundedRectangle(cornerRadius: radius, style: .continuous)
            )
    }
}

extension View {
    public func roundedRectBorderOverlay<S: ShapeStyle>(_ style: S, radius: CGFloat = 8, lineWidth: CGFloat = 10, inset: CGFloat = 0) -> some View {
        return modifier(RoundedRectBorderOverlay(style: style, radius: radius, lineWidth: lineWidth, inset: inset))
    }
}

struct RoundedRectBorderOverlay<S: ShapeStyle>: ViewModifier {
    
    var style: S
    var radius: CGFloat
    var lineWidth: CGFloat
    var inset: CGFloat
    
    func body(content: Content) -> some View {
        return content
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .inset(by: inset)
                    .stroke(style, lineWidth: lineWidth)
            )
    }
}
