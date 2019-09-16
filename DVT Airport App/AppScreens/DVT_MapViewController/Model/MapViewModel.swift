//
//  MapViewModel.swift
//  StarLinkApplication
//
//  Created by Administrator on 18/03/19.
//  Copyright © 2019 Sreelekh. All rights reserved.
//

import Foundation

class MapViewModel {
    var zone : String?
    var address : String?
    var currentLocationLatitude : String?
    var currentLocationLongitude : String?
   
    var nearByAirportData : [AirportsData]?
    
    func getNearByAirports(success: @escaping (()->()),failure: @escaping (_ alert: String)->()) {
   
        MHPHttpClientManager.SharedHM.getAirports(lat:currentLocationLatitude ?? "", lng:currentLocationLongitude ?? "", distance:"500" ){ (status, object, Alert) in
            if(status != 0){
                if object != nil {
                    if object?.count ?? 0 > 0 {
                    self.nearByAirportData = object
                    }
                    success()
                }
            }
            else
            {
                failure(Alert ?? "Something went wrong")
            }
        }
    }
}
