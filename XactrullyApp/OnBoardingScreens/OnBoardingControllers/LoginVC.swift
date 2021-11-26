//
//  LoginVC.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 17/11/2020.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var lblpass: UITextField!
    @IBOutlet weak var lblemail: UITextField!
    @IBOutlet weak var iv_eye: UIImageView!
    @IBOutlet weak var txtPass: UITextField!
    var dictData = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPass.isSecureTextEntry = true
        iv_eye.image = UIImage(named: "eye_hide")
    }
    
    @IBAction func btnhidePass_pressed(_ sender: Any) {
        if  txtPass.isSecureTextEntry == true{
            txtPass.isSecureTextEntry = false
            iv_eye.image = UIImage(named: "eye_icon")
        }else{
            txtPass.isSecureTextEntry = true
            iv_eye.image = UIImage(named: "eye_hide")
        }
        
    }
    @IBAction func btnCreateAccout_pressed(_ sender: Any) {
        
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnForgot_pressed(_ sender: Any) {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: "ForgotVC") as! ForgotVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSignin_Pressed(_ sender: Any) {
        let email = lblemail.text!
        let pass = lblpass.text!
        if !CHECK_EMAIL(testStr: email){
            self.alert(message: "please enter valid email")
        }else if pass.isEmpty{
            self.alert(message: "please enter password")
        }else{
            SigninCall(email: email, Password: pass)
//            let stb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = stb.instantiateViewController(withIdentifier: "ChooseRoleVC") as! ChooseRoleVC
//            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    func SigninCall(email:String,Password:String){
        let url = EndPoint.BASE_URL + "sign-in"
        let param = ["email":email,"password":Password]
        postWebCallWithKey(url: url, params: param, webCallName: "signin", sender: self) { (response, erorr) in
            if !erorr{
                let message = "\(response["message"])"
                let success = "\(response["success"])"
                if success == "true"{
                    saveUserData(user: response)
                    let stb = UIStoryboard(name: "Home", bundle: nil)
                    let vc = stb.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.alert(message: message)
                }
                
            }else{
                self.alert(message: erorr.description)
            }
        }
    }
}
