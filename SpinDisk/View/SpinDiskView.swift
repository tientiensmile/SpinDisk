//
//  SpinDiskView.swift
//  SpinDisk
//
//  Created by CM0763 on 2022/7/27.
//

import SwiftUI

struct SpinDiskView: View {
    
    @State private var count: String = "7"
    
    @State var lastPickedId: Int = 0
    
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.blue.opacity(0.1),
                                        .green.opacity(0.2)],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    InputView(count: $count)
                    DiskView(count: Int(count) ?? 1) { item in
                        lastPickedId = item.id
                        showAlert = true
                    }
                    .padding()
                    Spacer(minLength: (Device.screenHeight - Device.screenWidth) / 2)
                }
                .navigationTitle("旋轉盤")
                .font(.title2)
                .alert(isPresented: $showAlert, content: {
                    return Alert(title: Text("恭喜"),
                                 message: Text("\(lastPickedId + 1)中獎").font(.caption2),
                                 dismissButton: .default(Text("確認"),
                                                         action: { showAlert = false })
                    )
                })
            }
        }
    }
}

struct SpinDiskView_Previews: PreviewProvider {
    static var previews: some View {
        SpinDiskView()
    }
}
