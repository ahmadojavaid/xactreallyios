//
//  RegisterVC.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 17/11/2020.
//

import UIKit
import FirebaseAuth
class RegisterVC: UIViewController,ImagePickerDelegate,AuthUIDelegate {
    
    @IBOutlet weak var lblconfrimpass   : UITextField!
    
    @IBOutlet weak var lblpassword      : UITextField!
    @IBOutlet weak var lblcountry       : UITextField!
    @IBOutlet weak var lblphone         : UITextField!
    @IBOutlet weak var lblcode          : UITextField!
    @IBOutlet weak var lblemail         : UITextField!
    @IBOutlet weak var lbllastname      : UITextField!
    @IBOutlet weak var lblfirstname     : UITextField!
    @IBOutlet weak var lbluserimage     : UIImageView!
    @IBOutlet weak var checkedView      : UIView!
    @IBOutlet weak var iv_checked       : UIImageView!
    var all_countries                   = IsoCountries.allCountries
    var imagePicker                     : ImagePicker!
    var imageUploaded                   = false
    var selected_index                  = Int()
    let picker_code                     = UIPickerView()
    let picker_country                  = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        iv_checked.image = UIImage(named: "checked")
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        setCountryCode()
        
    }
    func setCountryCode()
    {
        
        picker_code.delegate        = self
        picker_code.dataSource      = self
        picker_country.delegate     = self
        picker_country.dataSource   = self
        lblcode.inputView           = picker_code
        lblcountry.inputView        = picker_country
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
        lblcountry.text = all_countries[selected_index].name
        lblcode.text = all_countries[selected_index].calling
    }
    @IBAction func btnVerify_pressed(_ sender: Any) {
        let fname   = lblfirstname.text!
        let sname   = lbllastname.text!
        let email   = lblemail.text!
        let code    = lblcode.text!
        let phone   = lblphone.text!
        let country = lblcountry.text!
        let pass    = lblpassword.text!
        let cnfrmpass = lblconfrimpass.text!
        if !imageUploaded{
            alert(message: "please select image")
        }else if fname.isEmpty{
            alert(message: "please enter first name")
        }else if sname.isEmpty{
            alert(message: "please enter first name")
        }else if !CHECK_EMAIL(testStr: email){
            alert(message: "please enter valid email")
        }else if code.isEmpty{
            alert(message: "please enter code")
        }else if phone.isEmpty{
            alert(message: "please enter phone")
        }else if country.isEmpty{
            alert(message: "please enter country")
        }else if pass.isEmpty
        {
            alert(message: "please enter password")
        }else if cnfrmpass.isEmpty{
            alert(message: "please enter password")
        }else if pass != cnfrmpass{
            alert(message: "password does not match")
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
            DEFAULTS.set(lbluserimage.image?.pngData(), forKey: "image")
            DEFAULTS.set(fname, forKey: "firstname")
            DEFAULTS.set(sname, forKey: "secondname")
            DEFAULTS.set(email, forKey: "email")
            DEFAULTS.set(country, forKey: "country")
            DEFAULTS.set(pass, forKey: "password")
            DEFAULTS.set(num, forKey: "phone")
            
            
            Signup(image: (lbluserimage.image?.pngData())!, firstname: fname, lastname: sname, email: email, phone: num, country: country, password: pass)
            
        }
        
        
    }
    
    @IBAction func btnSignup_pressed(_ sender: Any) {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_selectimage_pressed(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIView)
        
    }
    @IBAction func btnChecked_pressed(_ sender: Any) {
        if iv_checked.image == UIImage(named: "checked"){
            iv_checked.image = UIImage()
            checkedView.backgroundColor = UIColor.white
        }else{
            iv_checked.image = UIImage(named: "checked")
            checkedView.backgroundColor = UIColor(hex: "#F2A30F")
        }
        
        
    }
    @IBAction func btnPrivacy_pressed(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PrivacyAndPolicy") as! PrivacyAndPolicy
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTerm_pressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TermAndCondition") as! TermAndCondition
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func didSelect(image: UIImage?) {
        if let img = image
        {
            self.imageUploaded = true
            lbluserimage.image = img
        }
    }
    
    func Signup(image:Data,firstname:String,lastname:String,email:String,phone:String,country:String,password:String){
        let url     = EndPoint.BASE_URL + "sign-up"
        let param   = ["first_name":firstname,"last_name":lastname,"email":email,"phone":phone,"phone_verified":"0","country":country,"password":password]
        webCallWithImageWithNameKey(url: url, parameters: param, webCallName: "sign-up", imgData: image, imageName: "profile_pic", sender: self) { (response, error) in
            if !error{
                self.sendCode(num: phone)
                
            }else{
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
                    vc.imageData_string = self.lbluserimage.image!
                    vc.isForgot = false
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
extension RegisterVC: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return all_countries.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker_country{
            return  all_countries[row].name + all_countries[row].calling
        }else{
            return  all_countries[row].name + all_countries[row].calling
        }
        
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker_country{
            self.lblcountry.text = all_countries[row].name
        }else{
            self.lblcode.text = all_countries[row].calling
        }
        
        //        + " (" + all_countries[row].alpha2 + ")"
    }
    
}

extension RegisterVC : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == lblcode{
            
        }
    }
}
