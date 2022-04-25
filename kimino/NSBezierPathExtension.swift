//
//  NSbezierPathExtension.swift
//  kimino
//
//  Created by Cocoa on 25/04/2022.
//  Copyright © 2022 Cocoa. All rights reserved.
//

import Foundation
import AppKit


extension NSBezierPath {
    var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)

            switch type {
            case .moveTo:
                path.move(to: points[0])

            case .lineTo:
                path.addLine(to: points[0])

            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])

            case .closePath:
                path.closeSubpath()

            @unknown default:
                print("fuck me")
                break
            }
        }
        return path
    }
}
