//
//  UIHelper.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 24/11/2020.
//

import UIKit
import Nuke
struct UIHelper {
    init() {}
    static let shared = UIHelper()
    func popView(sender: UIViewController)
    {
        sender.navigationController?.interactivePopGestureRecognizer?.delegate = sender as? UIGestureRecognizerDelegate
        sender.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    func setupTable(nibName: String, tbl: UITableView)
    {
        
        tbl.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier : nibName)
        tbl.backgroundView      = .none
        tbl.backgroundColor     = .clear
        tbl.estimatedRowHeight  = 100
        tbl.rowHeight           = UITableView.automaticDimension
        tbl.separatorStyle      = .none
        tbl.showsVerticalScrollIndicator        = false
        tbl.showsHorizontalScrollIndicator      = false
    }
    
    func statuBarHeight(sender: UIViewController, viewHeightConstraint: NSLayoutConstraint)
    {
        let height = UIApplication.shared.statusBarFrame.size.height
        viewHeightConstraint.constant = height
    }
    //loadGif(name: "Source")
    func setImage(address: String, imgView: UIImageView){
        let userPlaceHolder = ImageLoadingOptions(
            placeholder: UIImage(named: "dummy"),
            transition: .fadeIn(duration: 0.33),
            failureImage: UIImage(named: "dummy"),
            contentModes: .init(success: .scaleAspectFill, failure: .scaleAspectFill, placeholder: .scaleAspectFill)
            
        )
        
        if let url = URL(string: address){
            Nuke.loadImage(with: url, options: userPlaceHolder, into: imgView)
        }
        else
        {
            Nuke.loadImage(with: URL(string: "URL")!, options: userPlaceHolder, into: imgView)
        }
        
    }
    
    func showAlert(msg: String, context: UIViewController)
    {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Login", style: .destructive, handler:{action in
            self.restartApplication()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        context.present(alert, animated: true)
    }
    func restartApplication () {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let navCtrl = stb.instantiateViewController(withIdentifier: "root") as! UINavigationController
        
        guard
            let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController
            else {
                return
        }
        navCtrl.view.frame = rootViewController.view.frame
        navCtrl.view.layoutIfNeeded()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = navCtrl
        })
        
    }
    
}


