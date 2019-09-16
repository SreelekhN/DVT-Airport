

import UIKit

struct AppDetails {
    //App Details
    static let APP_NAME = "DVT APP"
    static let ITUNES_URL = ""
    static let BUNDIL_ID = ""
    static let Google_Api_Key = "AIzaSyC6yrSowoFQWMJLD6nAEkCy33rZPbayVL4"
    static let FlightSearchCommonKey = ""
    
}
let appsession = UIApplication.shared.delegate as! AppDelegate
var sbMain = UIStoryboard(name: "Main", bundle: nil)

struct AppURL {
    //Base URLs
    
    static let BASE_URL = "http://aviation-edge.com/v2/public/"
    
    //Get URLs
    static let GET_NEARBY_AIRPORTS = BASE_URL + "nearby?"
    static let TIME_TABLE = BASE_URL + "timetable?"
   
}

struct AppAlertMsg {
    //App Alert Msg
    static let NetWorkAlertMessage = "No internet connection"
    static let serverNotReached = "The server could not be reached because of a connection problem"
    static let NoNotification = "No notification"
    
}

struct AppButtonTitles {

    static let okTitle = "Ok"
    static let cancel = "Cancel"
    static let retry = "Retry"
}

struct storyboardIdentifier {
    
    static let mainStoryBoard   = "Main"
    static let DVT_MapViewController   = "DVT_MapViewController"
    static let DVT_FlightListingViewController   = "DVT_FlightListingViewController"
}

struct MHPCellIdentifier {
    //App cell Identifiers
    static let Header = "Header"
    static let ContentCell = "ContentCell"
    
}

// MARK: - Device Parameter

enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

