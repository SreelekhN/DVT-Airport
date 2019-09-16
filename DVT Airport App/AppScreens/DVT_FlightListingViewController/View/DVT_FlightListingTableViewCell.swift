//
//  DVT_FlightListingTableViewCell.swift
//  DVT Airport App
//
//  Created by Exalture Software Labs on 10/09/19.
//  Copyright © 2019 Teenu Abraham. All rights reserved.
//

import UIKit

class DVT_FlightListingTableViewCell : UITableViewCell {
  
    
    
    //Header
    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var airportNameLbl: UILabel!
    @IBOutlet weak var placeLbl: UILabel!
    
    //Content
    @IBOutlet weak var planeImg: UIImageView!
    @IBOutlet weak var flightStatusImg: UIImageView!
    @IBOutlet weak var flightNameLbl: UILabel!
    @IBOutlet weak var flightStatusLbl: UILabel!
    
    @IBOutlet weak var flightDestinationLbl: UILabel!
    @IBOutlet weak var departureTimeLbl: UILabel!
    @IBOutlet weak var flightNumberLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowRadius = 5
        self.contentView.layer.shadowOpacity = 0.75
        self.contentView.layer.shadowOffset = .zero
    }
    
    func setHeaderData(model: AirportsData?){
        airportNameLbl.text = model?.nameAirport ?? ""
        placeLbl.text = (model?.codeIataAirport ?? "") + ", " + (model?.nameCountry ?? "")
    }
    
    func loadCellData(model:FlightsValue?){
        
        flightNameLbl.text = model?.airline?.name ?? ""

        if let time = model?.departure?.scheduledTime {
        let splitted = time.split(separator: "T")
        departureTimeLbl.text = String(splitted[1].prefix(5))
        }

        flightNumberLbl.text = model?.flight?.number ?? ""
        flightDestinationLbl.text = model?.arrival?.iataCode ?? ""
        flightStatusLbl.text = model?.status ?? ""
        if model?.status == "active" {
            flightStatusImg.image = UIImage(named: "flightNotification_GREEN")
        }else {
            flightStatusImg.image = UIImage(named: "flightNotification_RED")
        }
    }
}
