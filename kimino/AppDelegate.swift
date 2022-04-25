//
//  AppDelegate.swift
//  kimino
//
//  Created by Cocoa on 8/11/2019.
//  Copyright © 2019 Cocoa. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var keepFrontMenuItem: NSMenuItem!
    var statusBarItem: NSStatusItem!
    var clockWindowController: Array<NSWindowController>!
    var isFloating: Bool!
    var clocks: Array<Clock>!
    var clockUpdateTimer: Timer!
    let settingsWindow: NSWindowController = {
        // lazy prepare and display the second clock window, London
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let settingsWindow = storyboard.instantiateController(withIdentifier: "KiminoSettings") as! NSWindowController
        return settingsWindow
    }()
    var statusBarIcon: StatusBarIcon

    required override init() {
        self.statusBarIcon = StatusBarIcon.init(frame: NSMakeRect(0, 0, StatusBarIcon.baseWidth, StatusBarIcon.baseHeight))
    }

    /// Button Action
    @objc func keepFrontAction() {
        // toggle floating
        isFloating = !isFloating
        // save user preference
        UserDefaults.standard.set(isFloating, forKey: "keepfront")
        // do the actual functionality
        keepFront()
    }
    
    /// Actual keep front functionality
    func keepFront() {
        // update diplayed status
        keepFrontMenuItem.title = "Keep Front: \(isFloating ? "On" : "Off")"
        
        // change window level accordingly
        if isFloating {
            self.clockWindowController.forEach { windowController in
                windowController.window!.level = .floating
            }
        } else {
            self.clockWindowController.forEach { windowController in
                windowController.window!.level = .normal
            }
        }
    }
    
    /// Show settings window in front
    @objc func showSettings() {
        settingsWindow.showWindow(self)
        settingsWindow.window?.orderFrontRegardless()
    }
    
    /// Quit this application
    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
    
    /// Show clock with timezone and its font color
    /// - Parameters:
    ///   - timeZone: which time it should display
    ///   - clockColor: the font color
    func showClock(clock: Clock) {
        // prepare and display the second clock window, London
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let kiminoWindowController = storyboard.instantiateController(withIdentifier: "KiminoTime") as! NSWindowController
        if let kiminoWindow = kiminoWindowController.window {
            let kiminoView = kiminoWindow.contentViewController?.view as! KiminoView
            kiminoView.clock = clock
            // bring front
            kiminoWindow.orderFront(self)
            // append the second window to `clockWindow` array
            self.clockWindowController.append(kiminoWindowController)
        }
    }
    
    /// Archive clock model into property list compatible data
    /// - Parameter clocks: An array of instances of Clock
    public static func archiveClocks(clocks: Array<Clock>) -> Array<Data> {
        return clocks.map { (clock) -> Data in NSKeyedArchiver.archivedData(withRootObject: clock) }
    }
    
    /// Load saved clocks from ser defaults
    public static func loadClocks() -> Array<Clock> {
        let clocks = UserDefaults.standard.array(forKey: "clocks")
        
        // if there is no clocks available
        if clocks == nil || clocks?.count == 0 {
            // then add London as default clock
            let london: Clock = Clock.init(timezone: "Europe/London", color: NSColor(red: 0, green: 0.628, blue: 1, alpha: 1))!
            let defaultClocks = [london]
            UserDefaults.standard.setValue(AppDelegate.archiveClocks(clocks: defaultClocks), forKey: "clocks")
            return defaultClocks
        } else {
            var validClocks: Array<Clock> = Array.init()
            for maybeClock in clocks! {
                if let clockData = maybeClock as? Data {
                    if let clock = NSKeyedUnarchiver.unarchiveObject(with: clockData) as? Clock {
                        validClocks.append(clock)
                    }
                }
            }
            return validClocks
        }
    }
    
    /// Save clocks to user defaults
    /// - Parameter clocks: An array of instances of Clock
    public static func saveClocks(clocks: Array<Clock>) {
        UserDefaults.standard.setValue(AppDelegate.archiveClocks(clocks: clocks), forKey: "clocks")
    }
    
    /// Show all clocks saved in user defaults
    func showAllClocks() {
        if self.clockUpdateTimer != nil {
            self.clockUpdateTimer.invalidate()
            self.clockUpdateTimer = nil
        }
        
        if self.clockWindowController != nil {
            self.clockWindowController.forEach { windowController in
                windowController.close()
            }
        }
        
        // put the first clock window into `clockWindow` array
        self.clockWindowController = Array.init()
        
        self.clocks = AppDelegate.loadClocks()
        AppDelegate.saveClocks(clocks: self.clocks)
        
        self.clocks.forEach { (clock) in showClock(clock: clock) }
        
        // place clock windows to top right
        var y: CGFloat = 40
        for windowController in self.clockWindowController {
            placeWindow(windowController.window!, 100, y)
            y += 75
        }
        
        // update every second
        self.clockUpdateTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.clockWindowController.forEach({ window in
                let view = window.contentViewController?.view as! KiminoView
                view.update()
            })
            let localTime = Date().localTime()
            let hour = UInt8(localTime[0])!
            let minute = UInt8(localTime[1])!
            self.statusBarIcon.updateImage(hour, minute)
        }
    }
    
    /// Setup after application finishing launching
    ///
    /// - Parameter aNotification: unused
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        showAllClocks()
        
        // Status Bar
        let statusMenu = NSMenu(title: "kimino")
        keepFrontMenuItem = NSMenuItem(title: "Keep Front", action: #selector(AppDelegate.keepFrontAction), keyEquivalent: "k")
        
        let configMenuItem = NSMenuItem(title: "Settings", action: #selector(AppDelegate.showSettings), keyEquivalent: ",")
        
        let quiteMenuItem = NSMenuItem(title: "Quit", action: #selector(AppDelegate.quit), keyEquivalent: "q")
        
        statusMenu.addItem(keepFrontMenuItem)
        statusMenu.addItem(configMenuItem)
        statusMenu.addItem(quiteMenuItem)

        self.statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        self.statusBarItem.menu = statusMenu
        if let button = self.statusBarItem.button {
            button.addSubview(self.statusBarIcon)
            self.statusBarIcon.setFrameSize(button.frame.size)
        }

        // restore user defaults
        isFloating = UserDefaults.standard.bool(forKey: "keepfront")
        keepFront()
    }
    
    /// Place NSWindow to specific postion with respect to the screen
    ///
    /// - Parameters:
    ///   - window: window to be replaced
    ///   - right: pixels to the right edge
    ///   - top: pixels to the top edge
    func placeWindow(_ window: NSWindow, _ right: CGFloat, _ top: CGFloat) {
        if let screen = window.screen {
            let screenRect = screen.visibleFrame
            let newOriginX = screenRect.maxX - window.frame.width - right
            let newOriginY = screenRect.maxY - window.frame.height - top
            window.setFrameOrigin(NSPoint(x: newOriginX, y: newOriginY))
        }
    }
}

extension Date {
    func localTime() -> [Substring] {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone.current
        let currentTime = formatter.string(from: Date())
        return currentTime.split(separator: ":")
    }
}
