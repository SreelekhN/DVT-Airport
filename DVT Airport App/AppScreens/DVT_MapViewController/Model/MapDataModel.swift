//
//  FlightListingDataModel.swift
//  DVT Airport App
//
//  Created by Exalture Software Labs on 10/09/19.
//  Copyright © 2019 Teenu Abraham. All rights reserved.
//

import Foundation

// MARK: - AirportsData

struct LinesData: Codable {
    var data : [AirportsData]?
}

struct AirportsData: Codable {
    var nameAirport, codeIataAirport, codeIcaoAirport, latitudeAirport, longitudeAirport, timezone, GMT, phone, nameCountry, codeIso2Country, codeIataCity, distance: String?
}

struct fail : Codable {
    var text : String
}
