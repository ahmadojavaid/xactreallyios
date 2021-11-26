//
//  HomeVC.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 18/11/2020.
//

import UIKit

class HomeVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(DEFAULTS.string(forKey: "brearer_token")!)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnStrat_pressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
