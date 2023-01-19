//
//  Color+Extension.swift
//  Runner
//
//  Created by MacPro13 on 18/01/2023.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
extension Color {
    init(r: Int, g: Int, b: Int, a: Int) {
        self.init(red: Double(r) / 255.0, green: Double(g)/255.0, blue: Double(b)/100)
    }
    
    static let appPrimaryColor = Color.init(red: 0.10196078431372549, green: 0.13725490196078433, blue: 0.4980392156862745)
    static let appPrimaryLightColor = Color.init(r: 194, g: 221, b: 248, a: 100)
    static let appGreyColor = Color(red: 0.5411764705882353, green: 0.5411764705882353, blue: 0.5568627450980392)
    static let appGreenColor = Color(red: 0.18823529411764706, green: 0.8196078431372549, blue: 0.34509803921568627)
    static let appBackgroundColor = Color.init(r: 252, g: 250, b: 243, a: 100)
    static let appLightBlueColor = Color(r: 100, g: 181, b: 245, a: 100)
}
