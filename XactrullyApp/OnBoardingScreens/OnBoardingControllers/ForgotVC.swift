//
//  ForgotVC.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 17/11/2020.
//

import UIKit
import FirebaseAuth
class ForgotVC: UIViewController,AuthUIDelegate {
    var selected_index            = Int()
    var all_countries             = IsoCountries.allCountries
    let picker_code               = UIPickerView()
    @IBOutlet weak var lblphone: UITextField!
    @IBOutlet weak var lblcode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCountryCode()
        // Do any additional setup after loading the view.
    }
    
    func setCountryCode()
    {
        
        picker_code.delegate        = self
        picker_code.dataSource      = self
        lblcode.inputView           = picker_code
        let locale = Locale.current
        let country = locale.regionCode!
        print(country)
        for i  in 0..<all_countries.count
        {
            if all_countries[i].alpha2 == country
            {
                selected_index = i
            }
        }
        lblcode.text = all_countries[selected_index].calling
    }
    @IBAction func btnBack_pressd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnProceed_pressed(_ sender: Any) {
        let phone = lblphone.text!
        let code = lblcode.text!
        if phone.isEmpty{
            self.alert(message: "please enter phone")
        }else{
            var num = String()
            if phone.first == "0"
            {
                num = code + "\(phone.dropFirst())"
            }
            else
            {
                num = code + "\(phone)"
            }
            CheckPhone(phone: num)
        }
        
        //        let stb = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = stb.instantiateViewController(withIdentifier: "VerifyVc") as! VerifyVc
        //        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func CheckPhone(phone:String){
        DEFAULTS.setValue(phone, forKey: "phone")
        let url = EndPoint.BASE_URL + "check/phone"
        let param = ["phone":phone]
        postWebCallWithKey(url: url, params: param, webCallName: "check/phone", sender: self) { (response, error) in
            if !error{
                
                let success = "\(response["success"])"
                let message = "\(response["message"])"
                if success == "true"{
                    let token = "\(response["user"]["auth_token"])"
                    DEFAULTS.setValue(token, forKeyPath: "brearer_token")
                    self.sendCode(num: phone)
                }else{
                    self.alert(message: message)
                }
            }
            else{
                self.alert(message: error.description)
            }
        }
        
    }
    func sendCode(num:String)
    {
        let alert = UIAlertController(title: "Phone number", message: "Is this your phone number? \n \(num)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
            let trimmed = num.replacingOccurrences(of: " ", with: "")
            showProgress()
            PhoneAuthProvider.provider().verifyPhoneNumber(trimmed, uiDelegate: self) { (verificationID, error) in
                if error != nil
                {
                    print("eror: \(String(describing: error?.localizedDescription))")
                    self.alert(message: "Could not send code, please try later")
                }
                else
                {
                    dismissProgress()
                    print("Code Sent...")
                    let stb = UIStoryboard(name: "Main", bundle: nil)
                    let vc = stb.instantiateViewController(withIdentifier: "VerifyVc") as! VerifyVc
                    vc.verificationID_string = verificationID!
                    vc.isForgot = true
                    self.navigationController?.pushViewController(vc, animated: true)
                    print("verification id")
                    print(verificationID!)
                    
                    //self.codeSentState()
                }
            }
        }
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
extension ForgotVC: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return all_countries.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return  all_countries[row].name + all_countries[row].calling
        
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.lblcode.text = all_countries[row].calling
        
        //        + " (" + all_countries[row].alpha2 + ")"
    }
    
}

extension ForgotVC : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == lblcode{
            
        }
    }
}
