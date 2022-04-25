//
//  StatusBarIcon.swift
//  kimino
//
//  Created by Cocoa on 25/04/2022.
//  Copyright © 2022 Cocoa. All rights reserved.
//

import Foundation
import AppKit

class StatusBarIcon: NSView {
    var minute: UInt8 = 0
    var hour: UInt8 = 0

    // original vector image is drawn on a 100.0-by-100.0 canvas
    static let baseWidth: CGFloat  = 100.0
    static let baseHeight: CGFloat = 100.0
    static let baseMinuteLength: CGFloat = 30.0
    static let baseHourLength: CGFloat = 22.0

    let ovalPath: NSBezierPath = {
        return NSBezierPath(ovalIn: NSRect(x: 12, y: 12, width: 76, height: 76))
    }()

    let minutePath: NSBezierPath = {
        return NSBezierPath(roundedRect: NSRect(x: 49, y: 48.5, width: 2.5, height: baseMinuteLength), xRadius: 1, yRadius: 1)
    }()

    let hourPath: NSBezierPath = {
        return NSBezierPath(roundedRect: NSRect(x: 49, y: 48.5, width: baseHourLength, height: 3), xRadius: 1.5, yRadius: 1.5)
    }()

    // proportionally scale by default
    var scaleProportional: Bool = true
    var scaleXMultiplier: CGFloat = 1.0
    var scaleYMultiplier: CGFloat = 1.0

    let ovalPathLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 1.0
        layer.strokeColor = NSColor.black.cgColor
        layer.fillColor = NSColor.clear.cgColor
        return layer
    }()

    let minutePathLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 0.7
        layer.strokeColor = NSColor.black.cgColor
        layer.fillColor = NSColor.clear.cgColor
        return layer
    }()

    let hourPathLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 0.8
        layer.strokeColor = NSColor.black.cgColor
        layer.fillColor = NSColor.clear.cgColor
        return layer
    }()

    func addLayers() {
        self.wantsLayer = true
        self.layer?.addSublayer(ovalPathLayer)
        self.layer!.addSublayer(minutePathLayer)
        self.layer!.addSublayer(hourPathLayer)
    }

    func updateScaleMultiplier(_ width: CGFloat, _ height: CGFloat) {
        self.scaleXMultiplier = width  / StatusBarIcon.baseWidth;
        self.scaleYMultiplier = height / StatusBarIcon.baseHeight;
        if self.scaleProportional {
            let newMultiplier: CGFloat
            newMultiplier = min(self.scaleXMultiplier, self.scaleYMultiplier)
            self.scaleXMultiplier = newMultiplier
            self.scaleYMultiplier = newMultiplier
        }

        let transform = NSAffineTransform.init()
        transform.scaleX(by: self.scaleXMultiplier, yBy: self.scaleYMultiplier)

        ovalPathLayer.path = transform.transform(ovalPath).cgPath
        minutePathLayer.path = transform.transform(minutePath).cgPath
        hourPathLayer.path = transform.transform(hourPath).cgPath
    }

    override func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
        updateScaleMultiplier(newSize.width, newSize.height)
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        updateScaleMultiplier(frameRect.width, frameRect.height)
        addLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addLayers()
    }

    func updateImage(_ hour: UInt8, _ minute: UInt8) {
        self.hour = hour
        self.minute = minute
        self.needsDisplay = true
    }

    override func draw(_ dirtyRect: NSRect) {
        let transform = NSAffineTransform.init()
        transform.scaleX(by: self.scaleXMultiplier, yBy: self.scaleYMultiplier)
        ovalPathLayer.path = transform.transform(ovalPath).cgPath

        let centrePoint = NSPoint(
            x: StatusBarIcon.baseWidth/2.0,
            y: StatusBarIcon.baseHeight/2.0)

        let minutePercentage = Double(self.minute) / 60.0
        let minuteDegrees = minutePercentage * 360.0
        let minuteEndpoint = NSPoint(
            x: centrePoint.x + sin(minuteDegrees/57.29578) * StatusBarIcon.baseMinuteLength,
            y: centrePoint.y + cos(minuteDegrees/57.29578) * StatusBarIcon.baseMinuteLength)

        let mPath = NSBezierPath()
        mPath.move(to: centrePoint)
        mPath.line(to: minuteEndpoint)
        mPath.close()
        minutePathLayer.path = transform.transform(mPath).cgPath

        var currentHour = Double(self.hour)
        if currentHour >= 12 {
            currentHour -= 12
        }
        let hourDegrees = currentHour * 30.0 + minutePercentage * 30.0
        let hourEndpoint = NSPoint(
            x: centrePoint.x + sin(hourDegrees/57.29578) * StatusBarIcon.baseHourLength,
            y: centrePoint.y + cos(hourDegrees/57.29578) * StatusBarIcon.baseHourLength)
        let hPath = NSBezierPath()
        hPath.move(to: centrePoint)
        hPath.line(to: hourEndpoint)
        hPath.close()
        hourPathLayer.path = transform.transform(hPath).cgPath
    }
}
