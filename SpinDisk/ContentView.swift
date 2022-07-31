//
//  ContentView.swift
//  SpinDisk
//
//  Created by CM0763 on 2022/7/27.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        SpinDiskView()
            .gesture(
                TapGesture()
                    .onEnded({ _ in
                        UIApplication.shared.endEditing()
                    })
                )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
