//
//  MapViewController.swift
//  MapCallouts
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/11/8.
//
//
/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 Header file for this sample's main NSViewController.
 */

import Cocoa
import MapKit

@objc(MapViewController)
class MapViewController: NSViewController, MKMapViewDelegate {
    
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var annotationStates: NSMatrix! // series of check boxes to hide/show annotations
    @IBOutlet var toggleAllCheckBox: NSButtonCell!
    var mapAnnotations: [MKAnnotation] = []
    
    var myPopover: NSPopover?    // popover to display Golden Gate bridge (or BridgeViewController)
    @IBOutlet var bridgeViewController: BridgeViewController!
    
    
    //MARK: -
    
    class func annotationPadding() -> CGFloat {return 10.0}
    class func calloutHeight() -> CGFloat {return 40.0}
    
    private func gotoDefaultLocation() {
        // start off by default in San Francisco
        var newRegion = MKCoordinateRegion()
        newRegion.center.latitude = 37.786996
        newRegion.center.longitude = -122.440100
        newRegion.span.latitudeDelta = 0.112872
        newRegion.span.longitudeDelta = 0.109863
        
        self.mapView.setRegion(newRegion, animated: true)
    }
    
    override func awakeFromNib() {
        // create our annotations array
        self.mapAnnotations = []
        
        // annotation for the City of San Francisco
        let sfAnnotation = SFAnnotation()
        self.mapAnnotations.append(sfAnnotation)
        
        // annotation for Golden Gate Bridge
        let bridgeAnnotation = BridgeAnnotation()
        self.mapAnnotations.append(bridgeAnnotation)
        
        // annotation for Japanese Tea Garden
        let item = CustomAnnotation()
        item.place = "Tea Garden"
        item.imageName = "teagarden"
        item.coordinate = CLLocationCoordinate2DMake(37.770, -122.4701)
        self.mapAnnotations.append(item)
        
        // annotation for Fisherman's Wharf
        let wharfAnnotation = WharfAnnotation()
        self.mapAnnotations.append(wharfAnnotation)
        
        self.gotoDefaultLocation()    // go to San Francisco
        
        // default by showing all annotations
        self.annotationStates.selectAll(self) // select all the annotation checkboxes
        self.mapView.addAnnotations(self.mapAnnotations)
        
        self.mapView.showsZoomControls = true
    }
    
    
    //MARK: - Action methods
    
    @IBAction func annotationsAction(_: Any) {
        
        let colIdx = self.annotationStates.selectedColumn
        let rowIdx = self.annotationStates.selectedRow
        let selectedCheckBox = self.annotationStates.cell(atRow: rowIdx, column: colIdx) as! NSButtonCell?
        
        self.gotoDefaultLocation()
        
        if selectedCheckBox === self.toggleAllCheckBox {
            // user chose "All" checkbox
            self.mapView.removeAnnotations(self.mapView.annotations)  // remove any annotations that exist
            
            let allCheckbox = self.annotationStates.cell(atRow: rowIdx, column: colIdx)
            if allCheckbox?.state ?? .off != .off {
                self.annotationStates.selectAll(self)
                self.mapView.addAnnotations(self.mapAnnotations)
            } else {
                self.annotationStates.deselectAllCells()
            }
        } else {
            // user chose an individual checkbox
            //
            // uncheck "All" checkbox
            self.toggleAllCheckBox?.state = .off
            
            if selectedCheckBox?.state ?? .off != .off {
                self.mapView.addAnnotation(self.mapAnnotations[colIdx])
            } else {
                self.mapView.removeAnnotation(self.mapAnnotations[colIdx])
            }
        }
    }
    
    @IBAction func bridgeInfoAction(_ targetButton: NSButton) {
        // user clicked the Info button inside the BridgeAnnotation
        //
        
        // configure the preferred position of the popover
        let prefEdge = NSRectEdge.maxY
        
        self.createPopover()
        self.myPopover?.show(relativeTo: targetButton.bounds, of: targetButton, preferredEdge: prefEdge)
    }
    
    private func createPopover() {
        if self.myPopover == nil {
            // create and setup our popover
            myPopover = NSPopover()
            
            self.myPopover!.contentViewController = self.bridgeViewController
            
            self.myPopover!.animates = true
            
            // AppKit will close the popover when the user interacts with a user interface
            // element outside the popover.  Note that interacting with menus or panels that
            // become key only when needed will not cause a transient popover to close.
            //
            self.myPopover!.behavior = .transient
        }
    }
    
    
    //MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var returnedAnnotationView: MKAnnotationView? = nil
        
        // in case it's the user location, we already have an annotation, so just return nil
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        // handle our custom annotations
        //
        if annotation is BridgeAnnotation { // for Golden Gate Bridge
            // create/dequeue the pin annotation view first
            returnedAnnotationView = BridgeAnnotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
            
            // add a detail disclosure button to the callout which will open a popover for the bridge
            let rightButton = NSButton(frame: NSMakeRect(0.0, 0.0, 100.0, 80.0))
            rightButton.title = "Info"
            rightButton.target = self
            rightButton.action = #selector(self.bridgeInfoAction(_:))
            rightButton.bezelStyle = .shadowlessSquare
            returnedAnnotationView!.rightCalloutAccessoryView = rightButton
        } else if annotation is WharfAnnotation { // for Fisherman's Wharf
            returnedAnnotationView = WharfAnnotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
            
            // provide an image view to use as the accessory view's detail view.
            let image = NSImage(named: NSImage.Name(rawValue: "wharf"))!
            let imageRect = NSMakeRect(0.0, 0.0, image.size.width, image.size.height)
            
            let imageView = NSImageView(frame: imageRect)
            imageView.image = image
            let custView = NSView(frame: imageRect)
            custView.addSubview(imageView)
            
            if #available(OSX 10.11, *) {
                returnedAnnotationView!.detailCalloutAccessoryView = custView
            }
        } else if annotation is SFAnnotation {   // for City of San Francisco
            // create/dequeue the city annotation
            //
            returnedAnnotationView = SFAnnotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
            
            returnedAnnotationView!.image = NSImage(named: NSImage.Name(rawValue: "flag"))
            
            // provide the left image icon for the annotation
            let sfImage = NSImage(named: NSImage.Name(rawValue: "SFIcon"))!
            let imageRect = NSMakeRect(0.0, 0.0, sfImage.size.width, sfImage.size.height)
            
            let sfIconView = NSImageView(frame: imageRect)
            sfIconView.image = sfImage
            let custView = NSView(frame: imageRect)
            custView.addSubview(sfIconView)
            
            returnedAnnotationView!.leftCalloutAccessoryView = custView
        } else if annotation is CustomAnnotation {  // for Japanese Tea Garden
            // create/dequeue tea garden annotation
            returnedAnnotationView = CustomAnnotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
        }
        
        return returnedAnnotationView
    }
    
}
