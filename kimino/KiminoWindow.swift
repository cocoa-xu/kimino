//
//  KiminoWindow.swift
//  kimino
//
//  Created by Cocoa on 8/11/2019.
//  Copyright © 2019 Cocoa. All rights reserved.
//

import Cocoa

class KiminoWindow: NSWindow {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        setupWindow()
    }
    
    func setupWindow() {
        isOpaque = false
        backgroundColor = NSColor.clear
        isMovableByWindowBackground = true
        styleMask = .borderless
    }
}
