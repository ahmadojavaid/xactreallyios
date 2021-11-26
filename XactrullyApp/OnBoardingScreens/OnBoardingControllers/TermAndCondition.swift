//
//  TermAndCondition.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 18/11/2020.
//

import UIKit

class TermAndCondition: UIViewController {
    
    @IBOutlet weak var lbltxt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getDicription()
    }
    
    @IBAction func btnBack_pressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDicription(){
        let url = EndPoint.BASE_URL + "terms-conditions"
        let param = ["":""]
        getWebCallKey(url: url, params: param, webCallName: "terms-conditions", sender: self) { (response, error) in
            if !error{
                let termsconditions = "\(response["terms_conditions"])"
                self.lbltxt.text = termsconditions
                
            }else{
                self.alert(message: error.description)
            }
            
        }
    }
}
