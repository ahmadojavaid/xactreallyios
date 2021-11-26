//
//  VerifyVc.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 17/11/2020.
//

import UIKit
import SwiftGifOrigin
import FirebaseAuth
class VerifyVc: UIViewController,UITextFieldDelegate,AuthUIDelegate {
    
    @IBOutlet weak var sixtxt       : UITextField!
    @IBOutlet weak var fivetxt      : UITextField!
    @IBOutlet weak var fourtxt      : UITextField!
    @IBOutlet weak var threetxt     : UITextField!
    @IBOutlet weak var twotxt       : UITextField!
    @IBOutlet weak var onetxt       : UITextField!
    @IBOutlet weak var resend_view  : UIView!
    @IBOutlet var digitFields       : [UITextField]!
    @IBOutlet weak var lbl_timmer   : UILabel!
    @IBOutlet weak var timmer_img   : UIImageView!
    @IBOutlet weak var timmer_view  : UIView!
    var verificationID_string       = String()
    var isForgot = false
    var imageData_string = UIImage()
    var counter                     = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        timmer_view.isHidden      = false
        timmer_img.image = UIImage.gif(name: "timmer_clear")
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        digitFields.forEach {
            configureDigitField($0)
        }
        
    }
    @objc func updateCounter() {
        //example functionality
        if counter > 0 {
            counter -= 1
            lbl_timmer.text = "\(counter)"
            resend_view.isHidden = true
        }
        else{
            resend_view.isHidden   = false
            timmer_view.isHidden      = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        digitFields[0].becomeFirstResponder()
    }
    
    fileprivate func configureDigitField(_ digitField: UITextField) {
        digitField.delegate = self
        digitField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    
    // Move to next field in digit fields if the value is populated
    @objc fileprivate func textFieldDidChange(textField: UITextField) {
        if textField.text?.count == 1 {
            let remaining = digitFields.filter { $0.text?.count == 0 }
            if remaining.count > 0 {
                remaining[0].becomeFirstResponder()
            } else {
                digitFields.forEach { $0.resignFirstResponder() }
            }
        }
    }
    
    
    @IBAction func btnBack_pressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSendagain_pressed(_ sender: Any) {
        sendCode(num: DEFAULTS.string(forKey: "phone")!)
        
    }
    
    @IBAction func btnverify_Pressed(_ sender: Any) {
        let one     = onetxt.text!
        let two     = twotxt.text!
        let three   = threetxt.text!
        let four    = fourtxt.text!
        let five    = fivetxt.text!
        let six     = sixtxt.text!
        
        if one.isEmpty{
            self.alert(message: "please enter code")
        }else if two.isEmpty{
            self.alert(message: "please enter code")
        }
        else if three.isEmpty{
            self.alert(message: "please enter code")
        }
        else if four.isEmpty{
            self.alert(message: "please enter code")
        }
        else if five.isEmpty{
            self.alert(message: "please enter code")
        }
        else if six.isEmpty{
            self.alert(message: "please enter code")
        }
        let code = one + two + three + four + five + six
        verifyCode(code: code)
        
    }
    func sendCode(num:String)
    {
        let trimmed = num.replacingOccurrences(of: " ", with: "")
        self.timmer_view.isHidden          = false
        self.counter                     = 60
        self.resend_view.isHidden     = false
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
                self.verificationID_string = verificationID!
                print("verification id")
                print(verificationID!)
                
                //self.codeSentState()
            }
        }
    }
    func verifyCode(code:String)
    {
        showProgress()
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: self.verificationID_string, verificationCode: code)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil
            {
                dismissProgress()
                self.alert(message: "Wrong Code..")
            } else
            {
                if self.isForgot == true{
                    dismissProgress()
                    let stb = UIStoryboard(name: "Main", bundle: nil)
                    let vc = stb.instantiateViewController(withIdentifier: "ChangePassVc") as! ChangePassVc
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else{
                    self.Signup(image: self.imageData_string.pngData()!, firstname: DEFAULTS.string(forKey: "firstname")!, lastname: DEFAULTS.string(forKey: "secondname")!, email: DEFAULTS.string(forKey: "email")!, phone: DEFAULTS.string(forKey: "phone")!, country: DEFAULTS.string(forKey: "country")!, password: DEFAULTS.string(forKey: "password")!)
                }
                
                
                
                
            }
        }
    }
    
    func Signup(image:Data,firstname:String,lastname:String,email:String,phone:String,country:String,password:String){
        let url     = EndPoint.BASE_URL + "sign-up"
        let param   = ["first_name":firstname,"last_name":lastname,"email":email,"phone":phone,"phone_verified":"1","country":country,"password":password]
        webCallWithImageWithNameKey(url: url, parameters: param, webCallName: "sign-up", imgData: image, imageName: "profile_pic", sender: self) { (response, error) in
            if !error{
                let message = "\(response["message"])"
                let token = "\(response["user"]["auth_token"])"
                DEFAULTS.setValue(token, forKeyPath: "brearer_token")
                let stb = UIStoryboard(name: "Main", bundle: nil)
                let vc = stb.instantiateViewController(withIdentifier: "ChooseRoleVC") as! ChooseRoleVC
                self.navigationController?.pushViewController(vc, animated: true)
                //self.alert(message: message)
                
            }else{
                self.alert(message: error.description)
            }
        }
        
    }
    
}
extension UIImageView {
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
              let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
}
