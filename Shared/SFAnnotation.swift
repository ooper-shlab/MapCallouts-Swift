//
//  SFAnnotation.swift
//  MapCallouts
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/11/8.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 The custom MKAnnotation object representing the city of San Francisco.
 */

#if os(iOS)
    import UIKit
#else
    import Cocoa
#endif
import MapKit

/// annotation for the city of San Francisco
@objc(SFAnnotation)
class SFAnnotation: NSObject, MKAnnotation {
    
    
    var coordinate: CLLocationCoordinate2D {
        let theCoordinate = CLLocationCoordinate2D(latitude: 37.786996, longitude: -122.419281)
        return theCoordinate
    }
    
    var title: String? {
        return "San Francisco"
    }
    
    // optional
    var subtitle: String? {
        return "Founded: June 29, 1776"
    }
    
    class func createViewAnnotationForMapView(mapview: MKMapView, annotation: MKAnnotation) -> MKAnnotationView {
        var returnedAnnotationView =
        mapview.dequeueReusableAnnotationViewWithIdentifier(String(SFAnnotation.self))
        if returnedAnnotationView == nil {
            returnedAnnotationView =
                MKAnnotationView(annotation: annotation, reuseIdentifier: String(SFAnnotation.self))
            
            returnedAnnotationView!.canShowCallout = true
            
            // offset the flag annotation so that the flag pole rests on the map coordinate
            returnedAnnotationView!.centerOffset = CGPointMake(returnedAnnotationView!.centerOffset.x + (returnedAnnotationView!.image?.size.width ?? 0)/2, returnedAnnotationView!.centerOffset.y - (returnedAnnotationView!.image?.size.height ?? 0)/2)
        } else {
            returnedAnnotationView!.annotation = annotation
        }
        return returnedAnnotationView!
    }
    
}