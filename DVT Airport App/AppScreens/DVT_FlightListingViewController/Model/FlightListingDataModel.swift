//
//  FlightListingDataModel.swift
//  DVT Airport App
//
//  Created by Exalture Software Labs on 13/09/19.
//  Copyright © 2019 Teenu Abraham. All rights reserved.
//

import Foundation

struct FlightsData: Codable {
    var data : [FlightsValue]?
}

struct FlightsValue: Codable {
    var type, status : String?
    var departure : FlightDep?
    var arrival : FlightArrival?
    var airline : FlightAirline?
    var flight : FlightFlight?
    
    
}

struct FlightDep: Codable {
    var iataCode, icaoCode, terminal, gate, baggage, delay, scheduledTime, estimatedTime, actualTime, estimatedRunway, actualRunway  : String?
}

struct FlightArrival: Codable {
    var iataCode, icaoCode, terminal, gate, baggage, delay, scheduledTime, estimatedTime, actualTime, estimatedRunway, actualRunway  : String?
    
}

struct FlightAirline: Codable {
    var name, iataCode, icaoCode : String?
    
}

struct FlightFlight: Codable {
    var number, iataCode, icaoCode : String?

}
