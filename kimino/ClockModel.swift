//
//  ClockModel.swift
//  kimino
//
//  Created by Cocoa on 19/12/2019.
//  Copyright © 2019 Cocoa. All rights reserved.
//

import Foundation
import Cocoa

class Clock : NSObject, NSCoding {
    var timezone: String
    var color: NSColor
    
    struct PropertyKey {
        static let timezone = "timezone"
        static let color = "color"
    }
    
    /// init Clock with timezone and its clock color
    /// - Parameters:
    ///   - timezone: which timezone it should display
    ///   - color: its font color
    init?(timezone: String, color: NSColor) {
        // timezone should not be an empty string
        guard !timezone.isEmpty else {
            return nil
        }
        
        self.timezone = timezone
        self.color = color
        super.init()
    }
    
    /// NSCoding - encoding
    /// - Parameter coder: encoder
    func encode(with coder: NSCoder) {
        // encode `timezone`
        coder.encode(timezone, forKey: PropertyKey.timezone)
        // encode `color`
        coder.encode(NSKeyedArchiver.archivedData(withRootObject: color), forKey: PropertyKey.color)
    }
    
    /// NSCoding - decoding
    /// - Parameter coder: decoder
    required convenience init?(coder: NSCoder) {
        // decode from coder
        // timesone should be a String
        guard let timezone = coder.decodeObject(forKey: PropertyKey.timezone) as? String else {
            return nil
        }
        
        // there should be color data
        guard let colorData = coder.decodeObject(forKey: PropertyKey.color) as? Data else {
            return nil
        }
        
        // and the data can be decoded into NSColor
        guard let color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? NSColor else {
            return nil
        }

        // try to init Clock
        self.init(timezone: timezone, color: color)
    }
}
