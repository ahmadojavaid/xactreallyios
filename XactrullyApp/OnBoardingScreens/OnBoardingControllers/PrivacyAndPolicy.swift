//
//  PrivacyAndPolicy.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 18/11/2020.
//

import UIKit

class PrivacyAndPolicy: UIViewController {
    
    @IBOutlet weak var lbltxt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getDicription()
    }
    
    
    @IBAction func btnBack_pressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDicription(){
        let url = EndPoint.BASE_URL + "privacy-policy"
        let param = ["":""]
        getWebCallKey(url: url, params: param, webCallName: "policy", sender: self) { (response, error) in
            if !error{
                let privacy_policy = "\(response["privacy_policy"])"
                self.lbltxt.text = privacy_policy
                
            }else{
                self.alert(message: error.description)
            }
            
        }
    }
}
