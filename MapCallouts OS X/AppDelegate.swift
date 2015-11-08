//
//  AppDelegate.swift
//  MapCallouts
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/11/8.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 Interface file for this sample's application delegate.
 */

import Cocoa

@NSApplicationMain
@objc(AppDelegate)
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet private var myWindowController: MyWindowController!
    
    @objc func applicationDidFinishLaunching(notification: NSNotification) {
        
    }
    
    // -------------------------------------------------------------------------------
    //	applicationShouldTerminateAfterLastWindowClosed:sender
    //
    //	NSApplication delegate method placed here so the sample conveniently quits
    //	after we close the window.
    // -------------------------------------------------------------------------------
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
    
}