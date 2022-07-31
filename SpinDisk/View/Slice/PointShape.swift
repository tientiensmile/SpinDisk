//
//  PointShape.swift
//  SpinDisk
//
//  Created by CM0763 on 2022/7/28.
//

import SwiftUI

struct PointerShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.size.width / 2, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
            path.addLine(to: CGPoint(x: rect.midX, y: 0))
        }
    }
}
