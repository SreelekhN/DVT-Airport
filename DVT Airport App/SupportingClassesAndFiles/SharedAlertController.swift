

import UIKit

class SharedAlertController: UIAlertController {
    
    var alert : UIAlertController?
    
    weak var alertdelegate:SharedAlertDelegate?
    
    static let sharedAlert = SharedAlertController()
    
    //MARK: - Public Accessors
    
    func createMsgAlert(Title title:String,Message msg:String,Style style:UIAlertController.Style,OKTitle okTtle:String, completion:@escaping () -> Void) {
        self.alert = UIAlertController(title: NSLocalizedString(title, comment: "") , message: NSLocalizedString(msg, comment: ""), preferredStyle: style)
        
        self.alert!.addAction(UIAlertAction(title: NSLocalizedString(okTtle, comment: ""), style: UIAlertAction.Style.default, handler: { action in
            if(self.alertdelegate != nil) {
                self.alert?.dismiss(animated: true, completion:nil)
                completion()
            }
        }))
        self.showAlert()
    }
    
    func createAlert(Title title:String,Message msg:String,Style style:UIAlertController.Style,Tag tag:Int,IsOkBtn okSts:Bool,OKTitle okTtle:String,okAction okActn:String,IsCncl cnclSts:Bool,CancelTitle cnclTttle:String,CancelAction cancelActn:String) {
        
        self.alert = UIAlertController(title: title, message: msg, preferredStyle: style)
        if okSts {
            self.alert!.addAction(UIAlertAction(title: okTtle, style: UIAlertAction.Style.default, handler: { action in
                if(self.alertdelegate != nil) {
                    self.alertdelegate?.takeActionOnAlert!(Action: okActn, Tag: tag)
                }
                
            }))
        }
        if cnclSts {
            self.alert!.addAction(UIAlertAction(title: cnclTttle, style: UIAlertAction.Style.destructive, handler: { action in
                if(self.alertdelegate != nil){
                    self.alertdelegate?.takeActionOnAlert!(Action: cancelActn, Tag: tag)
                }
            }))
        }
        self.showAlert()
    }
    func showAlert(){
        if self.alertdelegate != nil
        {
            let containerVC = self.alertdelegate as! UIViewController
            DispatchQueue.main.async {
                () -> Void in
                containerVC.present(self.alert!, animated: true, completion: nil)
            }
        }
    }
}

@objc protocol SharedAlertDelegate:class {
    
    @objc optional func takeActionOnAlert(Action action:String,Tag tag:Int)
}
