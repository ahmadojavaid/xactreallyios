//
//  ChooseRoleVC.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 18/11/2020.
//

import UIKit

class ChooseRoleVC: UIViewController {
    var status = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func btnAgent_pressed(_ sender: Any) {
        ChooseRole(status: "Agent")
    }
    
    
    @IBAction func btnConstroctor_pressed(_ sender: Any) {
        ChooseRole(status: "Contractor")
    }
    func ChooseRole(status:String){
        let url = EndPoint.BASE_URL + "choose/role"
        let param = ["role":status]
        postWebCallWithToken(url: url, params: param, webCallName: "role", sender: self) { (response, error) in
            if !error{
                let stb = UIStoryboard(name: "Main", bundle: nil)
                let vc = stb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.alert(message: error.description)
            }
        }
    }
}
