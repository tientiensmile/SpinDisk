//
//  DiskSliceView.swift
//  SpinDisk
//
//  Created by CM0763 on 2022/7/27.
//

import SwiftUI

struct DiskSliceView: View {
    
    let item: Item
    
    let startDegree: Double
    
    let delta: Double
    
    var body: some View {
        ZStack(alignment: .top) {
            DiskSliceShape(startDegree: startDegree - delta/2.0, deltaDegree: delta)
                .fill(item.color)
            DiskSliceShape(startDegree: startDegree - delta/2.0, deltaDegree: delta)
                .stroke(.black, lineWidth: 0.5)
            Text("\(item.id + 1)")
                .font(.system(.body, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .offset(x: 0, y: 12)
                .shadow(radius: 3)
        }
          
    }
}

struct DiskSliceView_Previews: PreviewProvider {
    static var previews: some View {
        DiskSliceView(item: Item(id: 0, color: .red), startDegree: -90, delta: 30)
    }
}
