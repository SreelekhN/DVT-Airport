//
//  FlightListingViewModel.swift
//  DVT Airport App
//
//  Created by Exalture Software Labs on 10/09/19.
//  Copyright © 2019 Teenu Abraham. All rights reserved.
//

import Foundation
class FlightListingViewModel {
  
    var airportFlightsData : [FlightsValue]?
    var airportData : AirportsData?
    
    func getAirportsTimeTable( success: @escaping (()->()),failure: @escaping (_ alert: String)->()) {
        
        MHPHttpClientManager.SharedHM.getAirportsFlightsData(  aiportCode: airportData?.codeIataAirport ?? "", type: "departure"){ (status, object, Alert) in
            if(status != 0){
                if object != nil {
                    if object?.count ?? 0 > 0 {
                        self.airportFlightsData = object
                    }
                    success()
                }
                failure("No data available")
            }
            else
            {
                failure(Alert ?? "Something went wrong")
            }
        }
    }
}
