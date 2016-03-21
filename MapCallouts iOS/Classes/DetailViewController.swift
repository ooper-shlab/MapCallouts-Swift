//
//  DetailViewController.swift
//  MapCallouts
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/11/8.
//
//
/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 The detail view controller used for displaying the Golden Gate Bridge either in a popover for iPad, or in a pushed view controller for iPhone.
 */

import UIKit

@objc(DetailViewController)
class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fit the our popover size to match our image size
        let imageView = self.view as! UIImageView
        
        // this will determine the appropriate size of our popover
        self.preferredContentSize = CGSizeMake(imageView.image!.size.width, imageView.image!.size.height)
        self.title = "Golden Gate"
    }
    
}