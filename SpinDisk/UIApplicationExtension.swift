//
//  UIApplicationExtension.swift
//  SpinDisk
//
//  Created by CM0763 on 2022/7/28.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

}
