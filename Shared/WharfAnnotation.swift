//
//  WharfAnnotation.swift
//  MapCallouts
//
//  Translated by OOPer in cooperation with shlab.jp, on 2016/3/21.
//
//
/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 The custom MKAnnotation object representing Fisherman's Wharf.
 */

import MapKit

@objc(WharfAnnotation)
class WharfAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        let theCoordinate = CLLocationCoordinate2D(
            latitude: 37.808333,
            longitude: -122.415556)
        return theCoordinate
    }
    
    // required if you set the MKPinAnnotationView's "canShowCallout" property to YES
    var title: String? {
        return "Fisherman's Wharf"
    }
    
    class func createViewAnnotationForMapView(mapView: MKMapView, annotation: MKAnnotation) -> MKAnnotationView {
        // try to dequeue an existing pin view first
        var returnedAnnotationView =
        mapView.dequeueReusableAnnotationViewWithIdentifier(NSStringFromClass(WharfAnnotation.self))
        if returnedAnnotationView == nil {
            returnedAnnotationView =
                MKPinAnnotationView(annotation: annotation,
                    reuseIdentifier: NSStringFromClass(WharfAnnotation.self))
            (returnedAnnotationView as! MKPinAnnotationView).animatesDrop = true
            (returnedAnnotationView as! MKPinAnnotationView).canShowCallout = true
            
                #if os(iOS)
                    (returnedAnnotationView as! MKPinAnnotationView).pinTintColor = UIColor.orangeColor()
                #else
                    if #available(OSX 10.11, *) {
                        (returnedAnnotationView as! MKPinAnnotationView).pinTintColor = NSColor.orangeColor()
                    }
                #endif
        }
        
        return returnedAnnotationView!
    }
    
}