//
//  FoolRedPointView.swift
//
//  Created by foolbear on 2019/12/25.
//  Copyright © 2019 Foolbear Co.,Ltd. All rights reserved.
//

import SwiftUI

public enum FoolRedPointState: Int, CustomStringConvertible {
    case hide = 0
    case show
    case blink
    
    public var description: String {
        switch self {
        case .hide:
            return "hide"
        case .show:
            return "show"
        case .blink:
            return "blink"
        }
    }
}

@available(iOS 13.0, *)
struct FoolRedPointView<Presenting, RedPoint>: View where Presenting: View, RedPoint: View {
    let presenting: () -> Presenting
    var redPoint: () -> RedPoint
    var size: CGSize
    var alignment: Alignment
    @Binding var state: FoolRedPointState
    @State private var blinkState = true
    
    var body: some View {
        var offsetX: CGFloat = 0
        var offsetY: CGFloat = 0
        switch alignment {
        case .center:
            offsetX = 0; offsetY = 0
        case .top:
            offsetX = 0; offsetY = -size.height/2
        case .bottom:
            offsetX = 0; offsetY = size.height/2
        case .leading:
            offsetX = -size.width/2; offsetY = 0
        case .bottom:
            offsetX = size.width/2; offsetY = 0
        case .topLeading:
            offsetX = -size.width/2; offsetY = -size.height/2
        case .topTrailing:
            offsetX = size.width/2; offsetY = -size.height/2
        case .bottomLeading:
            offsetX = -size.width/2; offsetY = size.height/2
        case .bottomTrailing:
            offsetX = size.width/2; offsetY = size.height/2
        default:
            offsetX = 0; offsetY = 0
        }
        
        return
            ZStack(alignment: .center) {
                presenting().overlay(
                    Group {
                        if state == .hide {
                            EmptyView()
                        } else if state == .show {
                            redPoint()
                        } else {
                            redPoint()
                                .opacity(blinkState ? 1.0 : 0.0).animation(Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true))
                                .onAppear() { self.blinkState.toggle() }
                        }}
                        .frame(width: size.width, height: size.height)
                        .offset(x: offsetX, y: offsetY)
                    , alignment: alignment)
        }
    }
}

@available(iOS 13.0, *)
public extension View {
    
    func foolRedPoint<RedPoint>(
        state: Binding<FoolRedPointState>,
        size: CGSize = CGSize(width: 8, height: 8),
        alignment: Alignment = .topLeading,
        redPoint: @escaping () -> RedPoint)
        -> some View
        where RedPoint: View {
            FoolRedPointView(presenting: { self }, redPoint: redPoint, size: size, alignment: alignment, state: state)
    }
    
    func foolRedPoint(
        state: Binding<FoolRedPointState>,
        size: CGSize = CGSize(width: 8, height: 8),
        alignment: Alignment = .topLeading)
        -> some View {
            FoolRedPointView(presenting: { self }, redPoint: { Circle().fill(Color.red) }, size: size, alignment: alignment, state: state)
    }
    
}
