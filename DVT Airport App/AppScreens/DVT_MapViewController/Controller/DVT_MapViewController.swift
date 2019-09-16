//
//  DVT_MapViewController.swift
//  DVT Airport App
//
//  Created by Exalture Software Labs on 10/09/19.
//  Copyright © 2019 Teenu Abraham. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class DVT_MapViewController: CommonViewController {
    
    let viewModel = MapViewModel()
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()
    let marker = GMSMarker()
    var selectedLocation : CLLocation?
    var state_marker_Dict = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setMap()
    }
    
    func apiCall() {
        noInternetAlert {
            self.apiCall()
        }
        self.viewModel.getNearByAirports(success:  {
            self.addNearByMarkers()
        },failure: {
            alert in
            self.showToast(message: alert)
        })
    }
    
    func setMap(){
        self.mapView?.isMyLocationEnabled = true
        self.locationManager.delegate = self
        mapView.settings.myLocationButton = true
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
    func addNearByMarkers(){
        if let states = self.viewModel.nearByAirportData {
        for state in states {
            let state_marker = GMSMarker()
            state_marker.position = CLLocationCoordinate2D(latitude: Double(Float(state.latitudeAirport ?? "0.00") ?? 0.00), longitude: Double(Float(state.longitudeAirport ?? "0.00") ?? 0.00))
            state_marker.title = state.nameAirport
            state_marker.icon = UIImage(named: "pinLocationImage")
            state_marker.snippet = state.nameCountry
            state_marker.map = mapView
            mapView.selectedMarker = state_marker
            state_marker_Dict.append(state_marker)
        }
        }
    }
    
}
