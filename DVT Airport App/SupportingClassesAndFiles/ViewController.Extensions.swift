//
//  ViewController.Extensions.swift
//  StarLinkApplication
//
//  Created by Administrator on 07/03/19.
//  Copyright © 2019 Sreelekh. All rights reserved.
//

import Foundation
import SystemConfiguration
import Alamofire

extension UIViewController {
    
    func alamofireRequestCancel(){
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
    
    typealias NoInternetAlertHandler = ()-> Void
    
    func connectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags : SCNetworkReachabilityFlags = []
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        if (isReachable && !needsConnection)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func noInternetAlert(handler: NoInternetAlertHandler?) {
        if !connectedToNetwork() {
            let alertVC = UIAlertController(title: AppAlertMsg.NetWorkAlertMessage, message: nil, preferredStyle: .alert)
            let retryAction = UIAlertAction(title: AppButtonTitles.retry, style: .default, handler: { (alertAction) in
                if let handler = handler {
                    handler()
                }
                else {
                    self.showToast(message: AppAlertMsg.NetWorkAlertMessage)
                }
            })
            alertVC.addAction(retryAction)
            self.present(alertVC, animated: true)
        }
    }
    
    func askConfirmation (title:String, message:String, completion:@escaping (_ result:Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title:  AppButtonTitles.okTitle, style: .default, handler: { action in
            completion(true)
        }))
        
        alert.addAction(UIAlertAction(title:  AppButtonTitles.cancel, style: .cancel, handler: { action in
            completion(false)
        }))
    }
    func askConfirmationToLogin (title:String, message:String, completion:@escaping (_ result:Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Login", comment: ""), style: .default, handler: { action in
            completion(true)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { action in
            completion(false)
        }))
    }
    
    func askConfirmationSingleButton (title:String, message:String, completion:@escaping (_ result:Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: AppButtonTitles.okTitle, style: .default, handler: { action in
            completion(true)
        }))
    }
}

extension UIViewController {
    
    var activityIndicatorTag: Int { return 999999 }
    
    
    func setClearNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    @objc func ReturnBack()  {
        
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            dismissAction()
        }
    }
    
    func dismissAction()  {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIViewController {
    func activityView(title:String, imageName:String, webSite:String){
        let image = UIImage(named: imageName)
        let myWebsite = NSURL(string:webSite)
        let shareAll = [title , image as Any, myWebsite as Any] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    func pushTo(name:String) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: name) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func pushTo(name: String, with param: [String: Any]){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: name) as? CommonViewController{
            vc.param = param
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func presentVC(name:String) {
        if let modelVC = self.storyboard?.instantiateViewController(withIdentifier: name) {
            let navController = UINavigationController(rootViewController: modelVC)
            self.present(navController, animated:true, completion: nil)
        }
    }
    
    func presentVCNoNav(name:String) {
        if let modelVC = self.storyboard?.instantiateViewController(withIdentifier: name) {
            self.present(modelVC, animated:true, completion: nil)
        }
    }
    
    func goToRootAppTabBarController(name:String) {
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let stry = UIStoryboard(name: "Main", bundle: nil)
        rootviewcontroller.rootViewController = stry.instantiateViewController(withIdentifier: name)
    }
    
    func pushTonavigationController(storyBoardID:String) {
        let eventsVC = self.storyboard?.instantiateViewController(withIdentifier: storyBoardID) as! UINavigationController
        self.navigationController?.pushViewController(eventsVC.viewControllers.first!, animated: true)
    }
    
}

extension UIViewController {
    func showToast(message: String, completion: @escaping (_ success: Bool) -> Void = {_ in }) {
        guard message.trimmingCharacters(in: .whitespaces).count > 0 else {return}
        guard let window = UIApplication.shared.keyWindow else {return}
        let messageLbl = UILabel()
        messageLbl.text = message
        messageLbl.textAlignment = .center
        messageLbl.font = UIFont(name: "Avenir-Book", size: 15.0)!
        messageLbl.textColor = .white
        messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.9)
        messageLbl.numberOfLines = 0
        messageLbl.lineBreakMode = .byWordWrapping
        messageLbl.sizeToFit()
        
        let textSize:CGSize = messageLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)
        let height = heightForView(text: message, font: UIFont(name: "Avenir-Book", size: 15.0)!, width: labelWidth + 30)
        messageLbl.frame = CGRect(x: 20, y: 64, width: labelWidth + 30, height: height + 20)
        messageLbl.center.x = window.center.x
        messageLbl.layer.cornerRadius = 5
        messageLbl.layer.masksToBounds = true
        window.addSubview(messageLbl)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 2, animations: {
                messageLbl.alpha = 0
            }) { (_) in
                messageLbl.removeFromSuperview()
                completion(true)
            }
        }
    }
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}

extension UIViewController {
    
    func reloadTableViewCell(tableView:UITableView,item:Int,section:Int){
        let indexPath = IndexPath(item: item, section: section)
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.endUpdates()
    }
    func reloadSection(tableView:UITableView,section:Int){
        let indexSet: IndexSet = [section]
        tableView.reloadSections(indexSet, with: .none)
    }
    func sectionDelete(tableView:UITableView,section:Int){
        let indexSet: IndexSet = [section]
        tableView.reloadSections(indexSet, with: .none)
    }
    func deleteRow(tableView:UITableView,section:Int,row:Int){
        let indexPath = IndexPath(item: row, section: section)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}

extension UIViewController {
    func reloadCollectionViewRows(the collectionview:UICollectionView,item:Int,section:Int){
        let indexPath = IndexPath(item: item, section: section)
        collectionview.reloadItems(at: [indexPath])
    }
}
