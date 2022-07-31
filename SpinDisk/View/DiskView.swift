//
//  DiskView.swift
//  SpinDisk
//
//  Created by CM0763 on 2022/7/27.
//

import SwiftUI

struct DiskView: View {
    
    @State var startingRotation: Double = 0
    @State var translation: Double = 0
    
    @State var startSpinCount: Int = 0
    @State var endSpinCount: Int = 0
    
    @GestureState private var dragOffset = CGSize.zero
    
    var count: Int
    
    let action: ((Item) -> Void)?
    
    private let startDegree: Double = -90
    
    private var delta: Double {
        return 360.0 / Double(count)
    }
    
    
    
    private var items: [Item] {
        var list: [Item] = []
        for i in 0..<count {
            let ratio = (Double(i+1) / Double(count))
            let item = Item(id: i, color: Color.init(hue: ratio, saturation: 1.0, brightness: 1.0))
            list.append(item)
        }
        return list
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill()
                    .foregroundColor(.white)
                    .frame(height: geometry.size.width)
                ForEach(items) { item in
                    DiskSliceView(item: item, startDegree: startDegree, delta: delta)
                        .frame(height: geometry.size.width)
                        .rotationEffect(.degrees(Double(item.id) * delta))
                }
                .rotationEffect(.degrees(startingRotation) + .degrees(translation / geometry.size.height * 100))
                
                PointerShape()
                    .fill(.white)
                    .shadow(color: Color.black.opacity(0.3), radius: geometry.size.height / 50, x: 0, y: 0)
                    .frame(width: geometry.size.width / 15, height: geometry.size.width / 5, alignment: .center)

     
            }
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        startingRotation = startingRotation.truncatingRemainder(dividingBy: 360)
                        translation = value.translation.height
                    })
                    .onEnded({ value in
                        let isClockwise = checkSign(value: value)
                        wheelOnEnded(value: value, geometry: geometry, isClockwise: isClockwise)
                        startSpinCount += 1
                    }))
        }
        
    }
    
    private func reset() {
        startSpinCount = 0
        endSpinCount = 0
        startingRotation = 0
        translation = 0
    }
    
    private func checkSign(value: DragGesture.Value) -> Bool {
        if value.startLocation.x < value.predictedEndLocation.x,
           value.startLocation.y < value.predictedEndLocation.y {
            return true
        }
        if value.startLocation.x > value.predictedEndLocation.x,
           value.startLocation.y > value.predictedEndLocation.y {
            return true
        }
        return false
    }
    
    private func wheelOnEnded(value: DragGesture.Value, geometry: GeometryProxy, isClockwise: Bool) {
        let sign: Double = isClockwise ? 1 : -1
        let velocity = abs(value.predictedEndTranslation.height - value.translation.height) / 400
        let duration = max(velocity, 0.2)
        let angularTranslation = sign * (value.predictedEndTranslation.height / geometry.size.height) * CGFloat(180)
        let desiredEndRotation = sign * (startingRotation + angularTranslation * (1 + velocity))
        let nearestStop = round(desiredEndRotation / delta) * delta
        let ratio = round(desiredEndRotation.truncatingRemainder(dividingBy: 360) / delta)
        let sliceIndex = (items.count - Int(ratio)) % items.count
        let animation = Animation.easeOut(duration: duration)
        withAnimation(animation) {
            startingRotation = nearestStop
            translation = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            endSpinCount += 1
            let index = items.index(items.startIndex, offsetBy: sliceIndex)
            if endSpinCount == startSpinCount {
                action?(items[index])
            }
            
        }
    }

    
}

struct DiskView_Previews: PreviewProvider {
    static var previews: some View {
        DiskView(count: 6) { item in
            print("item: \(item.id)")
        }
    }
}
