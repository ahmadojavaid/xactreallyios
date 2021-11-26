//
//  ChangePassVc.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 18/11/2020.
//

import UIKit

class ChangePassVc: UIViewController {
    
    @IBOutlet weak var ivNeweye: UIImageView!
    @IBOutlet weak var ivCnfrmeye: UIImageView!
    @IBOutlet weak var txtCnfrmPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNewPass.isSecureTextEntry = true
        txtCnfrmPass.isSecureTextEntry = true
        ivNeweye.image = UIImage(named: "eye_hide")
        ivCnfrmeye.image = UIImage(named: "eye_hide")
        
    }
    
    @IBAction func btnhideNew_pressed(_ sender: Any) {
        if  txtNewPass.isSecureTextEntry == true{
            txtNewPass.isSecureTextEntry = false
            ivNeweye.image = UIImage(named: "eye_icon")
        }else{
            txtNewPass.isSecureTextEntry = true
            ivNeweye.image = UIImage(named: "eye_hide")
        }
    }
    
    @IBAction func btnhideCnfrm_pressed(_ sender: Any) {
        if  txtCnfrmPass.isSecureTextEntry == true{
            txtCnfrmPass.isSecureTextEntry = false
            ivCnfrmeye.image = UIImage(named: "eye_icon")
        }else{
            txtCnfrmPass.isSecureTextEntry = true
            ivCnfrmeye.image = UIImage(named: "eye_hide")
        }
    }
    @IBAction func btnChangePassword(_ sender: Any) {
        ChangePass()
    }
    
    func ChangePass(){
        let pass      = txtNewPass.text!
        let cnfrmPass = txtCnfrmPass.text!
        if pass.isEmpty{
            self.alert(message: "please enter password")
        }else if pass != cnfrmPass {
            self.alert(message: "password does not match")
        }
        else{
            let url = EndPoint.BASE_URL + "change/password"
            let param = ["password":pass]
            postWebCallWithToken(url: url, params: param, webCallName: "change", sender: self) { (response, error) in
                if !error{
                    let status = "\(response["success"])"
                    if status == "true"{
                        let stb = UIStoryboard(name: "Main", bundle: nil)
                        let vc = stb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                    
                }else{
                    self.alert(message: error.description)
                }
                
            }
        }
        
    }
    
}
