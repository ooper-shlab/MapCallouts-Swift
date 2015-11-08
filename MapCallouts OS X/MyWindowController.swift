//
//  MyWindowController.swift
//  MapCallouts
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/11/8.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 Header file for this sample's main NSWindowController.
 */

import Cocoa

@objc(MyWindowController)
class MyWindowController: NSWindowController {
    
    @IBOutlet private var viewPlaceHolder: NSView!
    private var mainVC: MapViewController!
    
    //MARK: -
    
    override func awakeFromNib() {
        mainVC = MapViewController(nibName: "MainView", bundle: nil)
        self.viewPlaceHolder.addSubview(self.mainVC.view)
        
        // since we are manually adding the view hierarchy that belongs to MapViewController,
        // we need to add the proper auto layout constraints so that it shrinks and grows along
        // with our window's contentView
        //
        let viewControllerView = self.mainVC.view
        let viewsDictionary = ["viewControllerView": viewControllerView]
        self.window?.contentView?.addConstraints(NSLayoutConstraint
            .constraintsWithVisualFormat("V:|[viewControllerView]|",
                options: [],
                metrics: nil,
                views: viewsDictionary))
        self.window?.contentView?.addConstraints(NSLayoutConstraint
            .constraintsWithVisualFormat("H:|[viewControllerView]|",
                options: [],
                metrics: nil,
                views: viewsDictionary))
    }
    
}