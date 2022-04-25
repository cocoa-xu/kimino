//
//  KiminoSettingsWindow.swift
//  kimino
//
//  Created by Cocoa on 19/12/2019.
//  Copyright © 2019 Cocoa. All rights reserved.
//

import Cocoa

class KiminoSettingsWindow: NSWindow {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
    }
}

class KiminoSettingsView: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    @IBOutlet weak var clockTable: NSTableView!
    @IBOutlet weak var clockFontColor: NSColorWell!
    @IBOutlet weak var timeZoneMenu: NSPopUpButton!
    
    private var clocks: Array<Clock>!
    
    required init?(coder: NSCoder) {
        self.clocks = []
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        self.clockTable.delegate = self
        self.clockTable.dataSource = self
        self.clockTable.action = #selector(KiminoSettingsView.clickedOnRow)
        self.clockFontColor.action = #selector(KiminoSettingsView.changeColor)
        self.timeZoneMenu.action = #selector(KiminoSettingsView.changeTimeZone)
        setupTimezoneMenus()
    }
    
    override func viewDidAppear() {
        // `-[KiminoSettingsView viewDidAppear]` will be invoked
        // only when its window once got closed and now opened
        
        // so we reload all clocks from AppDelegate
        reloadClocks()
    }
    
    /// Clicked on row
    /// - Parameter sender: table view
    @objc func clickedOnRow(sender: NSTableView) {
        if sender.selectedRow < self.clocks.count && sender.selectedRow >= 0 {
            let clock = self.clocks[sender.selectedRow]
            self.setMenus(baseOn: clock)
        } else {
            sender.deselectRow(sender.selectedRow)
        }
    }
    
    /// Listen for color changes
    /// - Parameter sender: color well button
    @objc func changeColor(sender: Any) {
        if self.clockTable.selectedRow < self.clocks.count && self.clockTable.selectedRow >= 0 {
            self.clocks[self.clockTable.selectedRow].color = self.clockFontColor.color
        }
    }
    
    /// Listen for time zone changes
    /// - Parameter sender: timezone pop up menu
    @objc func changeTimeZone(sender: Any) {
        if self.clockTable.selectedRow < self.clocks.count && self.clockTable.selectedRow >= 0 {
            if let timezone = self.timeZoneMenu.titleOfSelectedItem {
                self.clocks[self.clockTable.selectedRow].timezone = timezone
            }
        }
    }
    
    /// Set corresponding menus
    /// - Parameter clock: An instance of Clock
    func setMenus(baseOn clock: Clock) {
        // set color
        self.clockFontColor.color = clock.color
        self.timeZoneMenu.setTitle(clock.timezone)
    }
    
    /// Reload clock table
    func reloadClocks(fromAppDelegate reload: Bool = true) {
        if reload {
            self.clocks = AppDelegate.loadClocks()
        }
        
        self.clockTable.reloadData()
        
        if self.clocks.count >= 1 {
            self.setMenus(baseOn: self.clocks[0])
        }
    }
    
    /// Setup timezone pop up menus
    func setupTimezoneMenus() {
        self.timeZoneMenu.removeAllItems()
        self.timeZoneMenu.addItems(withTitles: TimeZone.knownTimeZoneIdentifiers)
    }
    
    /// Number of rows in clock table
    /// - Parameter tableView: tableView
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.clocks.count;
    }
    
    /// Return corrresponding row cell
    /// - Parameters:
    ///   - tableView: which table view is asking for data
    ///   - tableColumn: which column it acquires
    ///   - row: which row it wants
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // since we only have one table view here
        // so we just skip some checks
        let clock = self.clocks[row]
        let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView
        cell?.textField?.stringValue = clock.timezone
        return cell
    }
    
    /// Add new clock
    /// - Parameter sender: Add button
    @IBAction func add(sender: Any) {
        self.clocks.append(Clock.init(timezone: "Europe/London", color: NSColor(red: 0.946, green: 0.829, blue: 0.243, alpha: 1))!)
        reloadClocks(fromAppDelegate: false)
    }
    
    /// Remove a clock in the table
    /// - Parameter sender: remove button
    @IBAction func remove(sender: Any) {
        if self.clockTable.selectedRow < self.clocks.count && self.clockTable.selectedRow >= 0 {
            if self.clocks.count > 1 {
                self.clocks.remove(at: self.clockTable.selectedRow)
                reloadClocks(fromAppDelegate: false)
            }
        }
    }
    
    /// Confirm all changes
    /// - Parameter sender: OK button
    @IBAction func confirm(sender: Any) {
        AppDelegate.saveClocks(clocks: self.clocks)
        let appDelegate = NSApp.delegate! as! AppDelegate
        appDelegate.showAllClocks()
        
        self.view.window!.close()
    }
    
    
    /// Cancel all changes
    /// - Parameter sender: cancel button
    @IBAction func cancel(sender: Any) {
        self.view.window!.close()
    }
}
