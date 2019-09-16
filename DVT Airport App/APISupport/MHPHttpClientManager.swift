import UIKit
import Alamofire
import NVActivityIndicatorView

class MHPHttpClientManager: NSObject, SharedAlertDelegate,
NVActivityIndicatorViewable {
    
    //MARK: - Shared Instance
    static let SharedHM = MHPHttpClientManager()
    
    //MARK:- get Device Token
    
    func getDeviceToken() -> String {
        
        if (UserDefaults.standard.object(forKey:  "deviceToken") != nil) {
            return UserDefaults.standard.string(forKey: "deviceToken")!
        }
        return Defaults.defaultDEVICETOCKEN
        
    }
    struct Defaults
    {
        static let defaultDEVICETOCKEN = "DEVICETOCKEN"
        
    }
    
    func getFireBaseKey() -> String {
        
        if (UserDefaults.standard.object(forKey:  "FIR") != nil) {
            return UserDefaults.standard.string(forKey: "FIR")!
        }
        return "FIREBASE"
        
    }
    
    func showhideHUD(viewtype: SHOWHIDEHUD,title: String)
    {
        switch viewtype {
        case .SHOW:
            DispatchQueue.main.async {
                NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
                NVActivityIndicatorView.DEFAULT_TYPE = .ballScaleMultiple
                NVActivityIndicatorView.DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME = 2
                NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE = CGSize(width: 100, height: 100)
                NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
                let activityData = ActivityData()
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
            }
        case .HIDE:
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

extension MHPHttpClientManager {
    
    func getAirports(lat:String, lng:String, distance:String, completion:@escaping ( _ status: Int,  _ object: [AirportsData]?,_ Alert : String?) -> ()) -> (){
        
        self.showhideHUD(viewtype: .SHOW, title: "Loading")
        let url = AppURL.GET_NEARBY_AIRPORTS + "key=\(AppDetails.FlightSearchCommonKey)" + "&lat=\(lat)" + "&lng=\(lng)" + "&distance=\(distance)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default ,headers: nil).responseString { response in
            print(response)
            if let jsonData = response.data {
                print("JSON: \(jsonData)") // your JSONResponse result
                
                let Object = try? JSONDecoder().decode([AirportsData].self, from: jsonData)
                self.showhideHUD(viewtype: .HIDE, title: "Loading")
                completion(1, Object, "")
            }
            else
            {
                self.showhideHUD(viewtype: .HIDE, title: "Loading")
                completion(0, nil, "Something went wrong.")
            }
        }
    }
    
    func getAirportsFlightsData(aiportCode:String, type:String, completion:@escaping ( _ status: Int,  _ object: [FlightsValue]?,_ Alert : String?) -> ()) -> (){
        
        self.showhideHUD(viewtype: .SHOW, title: "Loading")
        let url = AppURL.TIME_TABLE + "key=\(AppDetails.FlightSearchCommonKey)" + "&iataCode=\(aiportCode)" + "&type=\(type)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default ,headers: nil).responseString { response in
            print(response)
            if let jsonData = response.data {
                print("JSON: \(jsonData)") // your JSONResponse result
                
                let Object = try? JSONDecoder().decode([FlightsValue].self, from: jsonData)
                self.showhideHUD(viewtype: .HIDE, title: "Loading")
                completion(1, Object, "")
            }
            else
            {
                self.showhideHUD(viewtype: .HIDE, title: "Loading")
                completion(0, nil, "Something went wrong.")
            }
        }
    }
}
