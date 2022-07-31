//
//  InputView.swift
//  SpinDisk
//
//  Created by CM0763 on 2022/7/27.
//

import SwiftUI

struct InputView: View {
    
    @Binding var count: String
    
    var body: some View {
        HStack {
            Spacer()
            Text("總數：")
            TextField("", text: $count)
                .onChange(of: count, perform: { newValue in
                    if let new = Int(newValue), new < 0 {
                        count = "1"
                    }else if let new = Int(newValue), new > 50 {
                        count = "50"
                    }
                })
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: 80)
            Spacer()
        }
    }
}
