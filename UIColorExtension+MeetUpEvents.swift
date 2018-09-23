//
//  UIColor.swift
//  WeRISE Conf
//
//  Created by Alecsandra Konson on 11/10/17.
//  Copyright © 2017 wwcodeatl. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let woodstock = UIColor(hex: 0xA7EBEB)
    static let kennesaw = UIColor(hex: 0xECEE98)



    // based on tutorial https://www.youtube.com/watch?v=JI7-f3c1eEM
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
    
    // based on
    // https://iosdevcenters.blogspot.com/2016/03/extension-for-hex-color-code-to-uicolor.html
    func hexToColor(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        let hexInt = Int(self.intFromHexString(hexString: hexString))
        let color = UIColor(hex: hexInt, a: alpha)
        return color
    }
    
    func intFromHexString(hexString: String) -> Int {
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value - sets value via pointer, returns BOOL
        scanner.scanHexInt32(&hexInt)
        
        return Int(hexInt)
    }
    
}
