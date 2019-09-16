//
//  DVT_FlightListingViewController+TableView.swift
//  DVT Airport App
//
//  Created by Exalture Software Labs on 10/09/19.
//  Copyright © 2019 Teenu Abraham. All rights reserved.
//

import Foundation
import UIKit

extension DVT_FlightListingViewController : UITableViewDataSource,UITableViewDelegate
{
    //MARK: - TV datasource and delegates
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.viewModel.airportFlightsData?.count ?? 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if let headerCell = tableView.dequeueReusableCell(withIdentifier: MHPCellIdentifier.Header) as? DVT_FlightListingTableViewCell {
                headerCell.setHeaderData(model: self.viewModel.airportData)
                return headerCell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MHPCellIdentifier.ContentCell, for: indexPath) as? DVT_FlightListingTableViewCell {
                cell.clipsToBounds = true
                cell.layoutSubviews()
                cell.layoutIfNeeded()
                cell.loadCellData(model:self.viewModel.airportFlightsData?[indexPath.row])
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        flightListingTableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
    }
    
    
    //MARK: - Stret cell
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Making the first cell sticky and stretchy
        if scrollView.contentOffset.y < 0.0 {
            if let cell = flightListingTableView.cellForRow(at: IndexPath(row: 0, section: 0)) {
                cell.frame.origin.y = scrollView.contentOffset.y
                let originalHeight: CGFloat = 213.0
                cell.frame.size.height = originalHeight + scrollView.contentOffset.y * (-1.0)
            }
        }
    }
}

