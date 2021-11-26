//
//  Globals.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 24/11/2020.
//

import Foundation
import UIKit
import SwiftyJSON
import RappleProgressHUD
struct EndPoint {
    static let BASE_URL = "http://xactruly.herokuapp.com/api/"
    
}

var coverView : UIView?


func shwoProgress(){
    showProgress()
}

func showProgress(text:String = "Processing...") {
    
    let attributes = RappleActivityIndicatorView.attribute(style: RappleStyle.circle, tintColor: UIColor.black, screenBG: .white, progressBG: .black, progressBarBG: .purple, progreeBarFill: UIColor.red, thickness: 4)
    RappleActivityIndicatorView.startAnimatingWithLabel(text, attributes: attributes)
    
    /*
    progressView = UIView(frame: view.frame)
    progressView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    let label = UILabel()
    progressView?.translatesAutoresizingMaskIntoConstraints = false
    label.translatesAutoresizingMaskIntoConstraints = false
    progressView?.addSubview(label)
    view.addSubview(progressView!)
    label.text = text
    label.textAlignment = .center
    label.backgroundColor = .clear
    let constraints = [
        progressView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        progressView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        progressView!.leftAnchor.constraint(equalTo: view.leftAnchor),
        progressView!.rightAnchor.constraint(equalTo: view.rightAnchor),
        
        label.centerYAnchor.constraint(equalTo: progressView!.centerYAnchor),
        label.centerXAnchor.constraint(equalTo: progressView!.centerXAnchor)
    ]
    NSLayoutConstraint.activate(constraints)
    */
}
func dismissProgress() {
    RappleActivityIndicatorView.stopAnimation()
    //progressView?.removeFromSuperview()
}
    

func CHECK_EMAIL(testStr:String) -> Bool
{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}



func saveUserData(user: JSON){
    print("save user data")
    DEFAULTS.set("\(user["user"]["first_name"])", forKey: "first_name")
    DEFAULTS.set("\(user["user"]["last_name"])", forKey: "last_name")
    DEFAULTS.set("\(user["user"]["phone"])", forKey: "phone")
    DEFAULTS.set("\(user["user"]["email"])", forKey: "email")
    DEFAULTS.set("\(user["user"]["_id"])", forKey: "user_id")
    DEFAULTS.set("\(user["user"]["country"])", forKey: "country")
    DEFAULTS.set("\(user["user"]["auth_token"])", forKey: "brearer_token")
    DEFAULTS.set("\(user["user"]["profile_pic"])", forKey: "profile_pic")
    DEFAULTS.set("\(user["user"]["phone_verified"])", forKey: "phone_verified")
    
}


//func sideMenuSetup(view:UIView){
//    let stb = UIStoryboard(name: "Home", bundle: nil)
//    let vc = stb.instantiateViewController(withIdentifier: "Menu") as!
//        Menu
//    //let vc = Menu(nibName: "Menu", bundle: nil)
//    menu = SideMenuNavigationController(rootViewController: vc)
//    menu?.isNavigationBarHidden = true
//    menu?.leftSide = true
//    menu?.menuWidth = 300
//    SideMenuManager.default.leftMenuNavigationController = menu
//    SideMenuManager.default.addPanGestureToPresent(toView: view)
//}



