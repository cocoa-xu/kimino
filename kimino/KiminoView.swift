//
//  KiminoWindow.swift
//  kimino
//
//  Created by Cocoa on 8/11/2019.
//  Copyright © 2019 Cocoa. All rights reserved.
//

import Cocoa

class KiminoView: NSView {
    var clock: Clock!
    @IBOutlet weak var ledTextLabel: LEDTextLabel!

    /// redraw
    func update() {
        // digits on the clock
        let formatter = DateFormatter()
        // 24 hrs
        formatter.dateFormat = "HH:mm"
        // specific timezone
        formatter.timeZone = TimeZone.init(identifier: self.clock.timezone)
        let currentTime = formatter.string(from: Date())
        ledTextLabel.text = currentTime
        ledTextLabel.floatingPointStyle = IfAndOnlyIfCharIsDot
        ledTextLabel.fontHeight = 71.5
        ledTextLabel.accentColor = self.clock.color
    }

    /// draw clock interface
    ///
    /// - Parameter dirtyRect: rect
    override func draw(_ dirtyRect: NSRect) {
        // rectangle drawing
        NSGraphicsContext.saveGraphicsState()
        let rectanglePath = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: 214, height: 71), xRadius: 10, yRadius: 10)
        // clock background
        NSColor(red: 0, green: 0, blue: 0, alpha: 0.916).setFill()
        rectanglePath.fill()
        NSGraphicsContext.restoreGraphicsState()
    }
}
