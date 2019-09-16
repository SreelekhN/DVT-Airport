//
//  MapViewController+GoogleMap.swift
//  StarLinkApplication
//
//  Created by Administrator on 18/03/19.
//  Copyright © 2019 Sreelekh. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces
import CoreLocation

// MARK: - CLLOCATION DELEGATE

extension DVT_MapViewController : CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        let numLat = NSNumber(value: (location?.coordinate.latitude)! as Double)
        self.viewModel.currentLocationLatitude = numLat.stringValue
        let numLong = NSNumber(value: (location?.coordinate.longitude)! as Double)
        self.viewModel.currentLocationLongitude = numLong.stringValue
        self.apiCall()
        self.mapView?.animate(to: camera)
        self.mapView.settings.myLocationButton = true
        if location != nil {
            let coordinate = CLLocationCoordinate2DMake(location!.coordinate.latitude,location!.coordinate.longitude)
            //selectedLocation = location
            
            let geocoder = GMSGeocoder()
            geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
                
            }
        }
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
}


// MARK: - GMSMapViewDelegate

extension DVT_MapViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let geocoder = GMSGeocoder()
        let coordinate = position.target
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address:GMSAddress = response?.firstResult() {
                let lines = address.lines! as [String]
                self.viewModel.address = lines.joined(separator: "\n")
                self.viewModel.zone = address.locality
            }
        }
    }
    
    func mapView (_ mapView: GMSMapView, didEndDragging didEndDraggingMarker: GMSMarker) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
        // do something
        if let index = state_marker_Dict.firstIndex(of: marker) {
            if self.viewModel.nearByAirportData?.count ?? 0 > index {
            if let selectedAirportData = self.viewModel.nearByAirportData?[index] {
            let params = ["selectedAirport":selectedAirportData]
            pushTo(name: storyboardIdentifier.DVT_FlightListingViewController, with: params)
            }
            }
        }
        return true
    }
}


//MARK: - GMSAutocompleteViewControllerDelegate

extension DVT_MapViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude), zoom: 20.0)
        self.mapView?.animate(to: camera)
        self.selectedLocation = CLLocation(coordinate: place.coordinate, altitude: CLLocationDistance.init(), horizontalAccuracy: CLLocationAccuracy.init(), verticalAccuracy: CLLocationAccuracy.init(), course: CLLocationDirection.init(), speed: CLLocationSpeed.init(), timestamp: Date())
        
        marker.position = place.coordinate
        marker.title = place.name
        if let addressDict = place.addressComponents as NSArray? {
            for m in addressDict {
                if let dict = m as? GMSAddressComponent{
                    if let str : NSString = dict.type as NSString, str == "country" {
                        marker.snippet = dict.name
                        break
                    }
                }
            }
        }
        
        marker.appearAnimation = GMSMarkerAnimation.pop
        DispatchQueue.main.async {
            self.marker.map = self.mapView;
        }
        
        //labelAddress.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
