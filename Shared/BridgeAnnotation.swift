//
//  BridgeAnnotation.swift
//  MapCallouts
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/11/8.
//
//
/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 The custom MKAnnotation object representing the Golden Gate Bridge.
 */

#if os(iOS)
    import UIKit
#else
    import Cocoa
#endif
import MapKit

/// annotation for the Golden Gate bridge
@objc(BridgeAnnotation)
class BridgeAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        let theCoordinate = CLLocationCoordinate2D(latitude: 37.810000, longitude: -122.477450)
        return theCoordinate
    }
    
    // required if you set the MKPinAnnotationView's "canShowCallout" property to YES
    var title: String? {
        return "Golden Gate Bridge"
    }
    
    // optional
    var subtitle: String? {
        return "Opened: May 27, 1937"
    }
    
    class func createViewAnnotationForMapView(_ mapView: MKMapView, annotation: MKAnnotation) -> MKAnnotationView {
        // try to dequeue an existing pin view first
        var returnedAnnotationView =
        mapView.dequeueReusableAnnotationView(withIdentifier: String(describing: BridgeAnnotation.self))
        if returnedAnnotationView == nil {
            returnedAnnotationView =
                MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(describing: BridgeAnnotation.self))
            
            let pinAnnotationView = returnedAnnotationView as! MKPinAnnotationView
            if #available(OSX 10.11, *) {
                pinAnnotationView.pinTintColor = MKPinAnnotationView.purplePinColor()
            }
            pinAnnotationView.animatesDrop = true
            pinAnnotationView.canShowCallout = true
        }
        
        return returnedAnnotationView!
    }
    
}
