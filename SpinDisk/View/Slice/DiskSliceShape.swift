//
//  DiskSliceShape.swift
//  SpinDisk
//
//  Created by CM0763 on 2022/7/27.
//

import SwiftUI

struct DiskSliceShape: Shape {
    
    let startDegree: Double
    
    let deltaDegree: Double
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            path.move(to: center)
            path.addArc(center: center, radius: rect.height / 2, startAngle: .degrees(startDegree), endAngle: .degrees(startDegree + deltaDegree), clockwise: false)
        }
            
    }
}

struct DiskSliceShape_Previews: PreviewProvider {
    static var previews: some View {
        DiskSliceShape(startDegree: -90, deltaDegree: 30)
    }
}
