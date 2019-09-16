//
//  ViewController.swift
//  DVT Airport App
//
//  Created by Exalture Software Labs on 10/09/19.
//  Copyright © 2019 Teenu Abraham. All rights reserved.
//

import UIKit

class DVT_FlightListingViewController: CommonViewController, UIScrollViewDelegate {
    
    let viewModel = FlightListingViewModel()
    
    @IBOutlet weak var flightListingTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.flightListingTableView.isHidden = true
        self.flightListingTableView.contentInsetAdjustmentBehavior = .never
        apiCall()
        
    }
    @IBAction func backBtnAction(_ sender: UIButton) {
        ReturnBack()
    }
    
    func apiCall() {
        noInternetAlert {
            self.apiCall()
        }
        guard let passedData = self.param else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        if let getData = passedData["selectedAirport"] as? AirportsData {
            self.viewModel.airportData = getData
            self.viewModel.getAirportsTimeTable( success: {
                
                    self.flightListingTableView.isHidden = false
                    self.flightListingTableView.reloadData()
                
            },failure: {
                alert in
                self.showToast(message: alert)
            })
        }
    }
}
