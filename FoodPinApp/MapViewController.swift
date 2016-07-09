//
//  MapViewController.swift
//  FoodPinApp
//
//  Created by 随随意 on 16/7/7.
//  Copyright © 2016年 随随意. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var restaurant: Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location) { (placemarks, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            if placemarks != nil && placemarks?.count > 0 {
                let palcemark = placemarks![0]
                //add Annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                annotation.coordinate = palcemark.location!.coordinate
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        //        let identifier = "MyPin"
        //        if annotation.isKindOfClass(MKUserLocation) {
        //            return nil
        //        }
        //        // Reuse the annotation if possible
        //        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        //        if annotationView == nil {
        //            identifier)
        //        }
        //        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier:
        //        annotationView.canShowCallout = true
        //        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        //        leftIconView.image = UIImage(named: restaurant.image)
        //        annotationView.leftCalloutAccessoryView = leftIconView
        let identifier = "MyPin"
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
        }
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(data: restaurant.image)
        annotationView?.leftCalloutAccessoryView = leftIconView
        return annotationView
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
