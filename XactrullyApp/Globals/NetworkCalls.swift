//
//  NetworkCalls.swift
//  XactrullyApp
//
//  Created by Saeed Rehman on 24/11/2020.
//

import Foundation
import Alamofire
import SwiftyJSON
import FirebaseDatabase
let API_ERROR   = "Error at server, please try again"
let DEFAULTS    = UserDefaults.standard
let DatabaseRef = Database.database().reference()
let headers: HTTPHeaders = [
    "Accept":"application/json",
    "Authorization":"Bearer " + DEFAULTS.string(forKey: "brearer_token")!
]
let headersKEY: HTTPHeaders = [
    "Accept":"application/json",
    "Authorization": "Bearer " + "base64:cLHocpcnbza8oSOunXgTgLe5trNrMbG5oyuFor/SPNA="
]
func postWebCallWithKey(url:String, params: Parameters, webCallName: String,sender: UIViewController, completionHandler: @escaping (_ res:JSON, _ error: Bool)->Void)
{
    let baseurl = URL(string:url)!
    showProgress()
    print(webCallName)
    print(url)
    print(params)
    Alamofire.request(baseurl, method: .post, parameters: params, encoding: URLEncoding.default,headers: headersKEY).responseJSON{ (responseData) -> Void in
        if((responseData.result.value) != nil)
        {
            let a = JSON(responseData.result.value)
            dismissProgress()
            completionHandler(a, false)
            print(a)
        }
        else
        {
            let a = JSON()
            dismissProgress()
            print("Error is \(String(describing: responseData.result.error))")
            completionHandler(a, true)
            
        }
    }// Alamofire ends here
    
    
}

func postWebCallWithToken(url:String, params: Parameters, webCallName: String,sender: UIViewController, completionHandler: @escaping (_ res:JSON, _ error: Bool)->Void)
{
    let baseurl = URL(string:url)!
    showProgress()
    print(webCallName)
    print(url)
    print(params)
    Alamofire.request(baseurl, method: .post, parameters: params, encoding: URLEncoding.default,headers: headers).responseJSON{ (responseData) -> Void in
        if((responseData.result.value) != nil)
        {
            let a = JSON(responseData.result.value)
            dismissProgress()
            completionHandler(a, false)
            print(a)
        }
        else
        {
            let a = JSON()
            dismissProgress()
            print("Error is \(String(describing: responseData.result.error))")
            completionHandler(a, true)
            
        }
    }// Alamofire ends here
    
    
}
func postWebCallForLike(url:String, params: Parameters, webCallName: String,sender: UIViewController, completionHandler: @escaping (_ res:JSON, _ error: Bool)->Void)
{
    let baseurl = URL(string:url)!
    //NActivityIndicator(sender: sender)
    //startProgress(sender: sender)
    print(webCallName)
    print(url)
    print(params)
    Alamofire.request(baseurl, method: .post, parameters: params, encoding: URLEncoding.default,headers: headers).responseJSON{ (responseData) -> Void in
        if((responseData.result.value) != nil)
        {
            let a = JSON(responseData.result.value)
            //stopAtivityIndicator(sender: sender)
            //endProgress()
            //KRProgressHUD.dismiss()
            completionHandler(a, false)
            print(a)
        }
        else
        {
            let a = JSON()
            //dismissProgress()
            print("Error is \(String(describing: responseData.result.error))")
            completionHandler(a, true)
            
        }
    }// Alamofire ends here
    
    
}

func postWebCallWithTokenWithCodeAble(url:String, params: Parameters, webCallName: String,sender: UIViewController, completionHandler: @escaping (_ res:String, _ error: Bool)->Void)
{
    let baseurl = URL(string:url)!
    showProgress()
    //startProgress(sender: sender)
    print(webCallName)
    print(url)
    print(params)
    Alamofire.request(baseurl, method: .post, parameters: params, encoding: URLEncoding.default,headers: headers).responseString{ (responseData) -> Void in
        
        //        print(responseData)
        
        if((responseData.result.value) != nil)
        {
            
            let a = "\(responseData.value!)" //JSON(responseData.result.value)
            completionHandler(a, false)
            dismissProgress()
            print(a)
        }
        else
        {
            let a = ""
            dismissProgress()
            print("Error is \(String(describing: responseData.result.error))")
            completionHandler(a, true)
            
        }
    }// Alamofire ends here
    
    
}


func getWebCallWithTokenWithCodeAble(url:String, params: Parameters, webCallName: String,sender: UIViewController, completionHandler: @escaping (_ res:String, _ error: Bool)->Void)
{
    let baseurl = URL(string:url)!
    showProgress()
    print(webCallName)
    print(url)
    print(params)
    Alamofire.request(baseurl, method: .get, parameters: params, encoding: URLEncoding.default,headers: headers).responseString{ (responseData) -> Void in
        
        //        print(responseData)
        
        if((responseData.result.value) != nil)
        {
            
            let a = "\(responseData.value!)" //JSON(responseData.result.value)
            completionHandler(a, false)
            dismissProgress()
            print(a)
        }
        else
        {
            let a = ""
            dismissProgress()
            print("Error is \(String(describing: responseData.result.error))")
            completionHandler(a, true)
            
        }
    }// Alamofire ends here
    
    
}



func postWebCall(url:String, params: Parameters, webCallName: String,sender: UIViewController, completionHandler: @escaping (_ res:JSON, _ error: Bool)->Void)
{
    
    let baseurl = URL(string:url)!
    showProgress()
    print(webCallName)
    print(url)
    print(params)
    Alamofire.request(baseurl, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON{ (responseData) -> Void in
        if((responseData.result.value) != nil)
        {
            let a = JSON(responseData.result.value)
            dismissProgress()
            completionHandler(a, false)
            print(a)
        }
        else
        {
            let a = JSON()
            dismissProgress()
            print("Error is \(String(describing: responseData.result.error))")
            completionHandler(a, true)
            
        }
    }// Alamofire ends here
    
    
}


func postWebCallString(url:String, params: Parameters, webCallName: String,sender: UIViewController, completionHandler: @escaping (_ res:JSON, _ error: Bool)->Void)
{
    let baseurl = URL(string:url)!
    showProgress()
    print(webCallName)
    print(url)
    print(params)
    Alamofire.request(baseurl, method: .post, parameters: params, encoding: URLEncoding.default).responseString{ (responseData) -> Void in
        if((responseData.result.value) != nil)
        {
            dismissProgress()
            let a = JSON(responseData.result.value)
            completionHandler(a, false)
            print(a)
        }
        else
        {
            dismissProgress()
            let a = JSON()
            print("Error is \(String(describing: responseData.result.error))")
            completionHandler(a, true)
            
        }
    }// Alamofire ends here
    
    
}

func getWebCall(url:String, params: Parameters, webCallName: String,sender: UIViewController,  completionHandler: @escaping (_ res:JSON, _ error: Bool)->Void)
{
    showProgress()
    let baseurl = URL(string:url)!
    print(webCallName)
    print(url)
    print(params)
    Alamofire.request(baseurl, method: .get, parameters: params, encoding: URLEncoding.default,headers: headers).responseJSON{ (responseData) -> Void in
        if((responseData.result.value) != nil)
        {
            dismissProgress()
            let a = JSON(responseData.result.value)
            completionHandler(a, false)
            print(a)
        }
        else
        {
            dismissProgress()
            let a = JSON()
            print("Error is \(String(describing: responseData.result.error))")
            completionHandler(a, true)
            
        }
    }// Alamofire ends here
}
func getWebCallKey(url:String, params: Parameters, webCallName: String,sender: UIViewController,  completionHandler: @escaping (_ res:JSON, _ error: Bool)->Void)
{
    showProgress()
    let baseurl = URL(string:url)!
    print(webCallName)
    print(url)
    print(params)
    Alamofire.request(baseurl, method: .get, parameters: params, encoding: URLEncoding.default,headers: headersKEY).responseJSON{ (responseData) -> Void in
        if((responseData.result.value) != nil)
        {
            dismissProgress()
            let a = JSON(responseData.result.value)
            completionHandler(a, false)
            print(a)
        }
        else
        {
            dismissProgress()
            let a = JSON()
            print("Error is \(String(describing: responseData.result.error))")
            completionHandler(a, true)
            
        }
    }// Alamofire ends here
}
func getRegionWebCall(url:String, params: Parameters, webCallName: String,sender: UIViewController,  completionHandler: @escaping (_ res:JSON, _ error: Bool)->Void)
{
    //KRProgressHUD.showMessage("please wait...")
    let baseurl = URL(string:url)!
    print(webCallName)
    print(url)
    print(params)
    Alamofire.request(baseurl, method: .get, parameters: params, encoding: URLEncoding.default,headers: headers).responseJSON{ (responseData) -> Void in
        if((responseData.result.value) != nil)
        {
            //KRProgressHUD.dismiss()
            let a = JSON(responseData.result.value)
            completionHandler(a, false)
            print(a)
        }
        else
        {
            //KRProgressHUD.dismiss()
            let a = JSON()
            print("Error is \(String(describing: responseData.result.error))")
            completionHandler(a, true)
            
        }
    }// Alamofire ends here
}

func webCallWithImage(url:String, parameters: Parameters, webCallName: String, sender: UIViewController, completionHandler: @escaping (_ res:JSON, _ error:Bool)->Void)
{
    showProgress()
    print(url)
    print(parameters)
    Alamofire.upload(multipartFormData: { multipartFormData in
        //multipartFormData.append()
        for (key, value) in parameters
        {
            multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
        } //Optional for extra parameters
    },
    to:url,headers: headers)
    { (result) in
        switch result {
        case .success(let upload, _, _):
            upload.uploadProgress(closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
                print("uploding\(progress)")
                showProgress(text: "uploding\(progress)")
                let total = progress.totalUnitCount
                let obt  = progress.completedUnitCount
                let per = Double(obt) / Double(total) * 100
                let pp = Int(per)
                
            })
            
            upload.responseString{ response in
                print("Whatever")
                print(response)
                print("done")
                let a = JSON(response.result.value)
                print(a)
                dismissProgress()
                completionHandler(a, false)
            }
        case .failure(let encodingError):
            print(encodingError)
            let a = JSON()
            dismissProgress()
            completionHandler(a, true)
        }
    }
    
}

func webCallForMultipleImages(url:String,parameters: Parameters,webCallName:String,imgDate:[Data],imageName: String, sender:
                                UIViewController,completionHandler: @escaping (_ res:JSON, _ error:Bool)->Void)
{
    showProgress()
    Alamofire.upload(multipartFormData: { (multipartFormData : MultipartFormData) in
        let count = imgDate.count
        for i in 0..<count{
            multipartFormData.append(imgDate[i], withName: imageName + "[\(i)]", fileName: "photo\(i).jpeg" , mimeType: "image/jpeg")
            
        }
        for (key, value) in parameters {
            
            multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
        }
        print(multipartFormData)
    },to: EndPoint.BASE_URL + "create/post", headers: headers) { (result) in
        dismissProgress()
        switch result {
        
        case .success(let upload, _ , _):
            
            upload.uploadProgress(closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
                print("uploding\(progress)")
                let total = progress.totalUnitCount
                let obt  = progress.completedUnitCount
                let per = Double(obt) / Double(total) * 100
                let _ = Int(per)
                showProgress(text: "\(per)")
            })
            
            upload.responseJSON { response in
                dismissProgress()
                print(response.result.value!)
                let resp = response.result.value! as! NSDictionary
                if resp["success"] as! Bool == true{
                    print(response.result.value!)
                    
                }
                else{
                    
                }
                
                
            }
            
        case .failure(let encodingError):
            print("failed")
            print(encodingError)
            
        }
    }
    
}

func webCallForMultiplevideo(url:String,parameters: Parameters,webCallName:String,imgDate:[URL],imageName: String, sender:
                                UIViewController,completionHandler: @escaping (_ res:JSON, _ error:Bool)->Void)
{
    showProgress()
    Alamofire.upload(multipartFormData: { (multipartFormData : MultipartFormData) in
        let count = imgDate.count
        for i in 0..<count{
            multipartFormData.append(imgDate[i], withName: imageName + "[\(i)]", fileName: "video\(i).mp4" , mimeType: "video/mp4")
            
        }
        for (key, value) in parameters {
            
            multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
        }
        print(multipartFormData)
    },to: EndPoint.BASE_URL + "create/post", headers: headers) { (result) in
        dismissProgress()
        switch result {
        
        case .success(let upload, _ , _):
            
            upload.uploadProgress(closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
                print("uploding\(progress)")
                let total = progress.totalUnitCount
                let obt  = progress.completedUnitCount
                let per = Double(obt) / Double(total) * 100
                let _ = Int(per)
                showProgress(text: "\(per)")
            })
            
            upload.responseJSON { response in
                dismissProgress()
                print(response.result.value!)
                let resp = response.result.value! as! NSDictionary
                if resp["success"] as! Bool == true{
                    print(response.result.value!)
                    
                }
                else{
                    
                }
                
                
            }
            
        case .failure(let encodingError):
            print("failed")
            print(encodingError)
            
        }
    }
    
}

func webCallWithImageWithName(url:String, parameters: Parameters, webCallName: String, imgData:Data,imageName: String, sender: UIViewController,completionHandler: @escaping (_ res:JSON, _ error:Bool)->Void)
{
    showProgress()
    print(url)
    print(parameters)
    Alamofire.upload(multipartFormData: { multipartFormData in
        multipartFormData.append(imgData, withName: imageName,fileName: "image.png", mimeType: "image/png")
        for (key, value) in parameters
        {
            multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
        }
    },to:url,headers: headers)
    { (result) in
        switch result {
        case .success(let upload, _, _):
            upload.uploadProgress(closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
                print("uploding\(progress)")
                let total = progress.totalUnitCount
                let obt  = progress.completedUnitCount
                let per = Double(obt) / Double(total) * 100
                let _ = Int(per)
                
            })
            upload.responseJSON{ response in
                
                print(response)
                print("done")
                let a = JSON(response.result.value)
                print(a)
                dismissProgress()
                completionHandler(a, false)
                
            }
        case .failure(let encodingError):
            print(encodingError)
            let a = JSON()
            dismissProgress()
            completionHandler(a, true)
        }
    }
    
}
func webCallWithImageWithNameKey(url:String, parameters: Parameters, webCallName: String, imgData:Data,imageName: String, sender: UIViewController,completionHandler: @escaping (_ res:JSON, _ error:Bool)->Void)
{
    showProgress()
    print(url)
    print(parameters)
    Alamofire.upload(multipartFormData: { multipartFormData in
        multipartFormData.append(imgData, withName: imageName,fileName: "image.png", mimeType: "image/png")
        for (key, value) in parameters
        {
            multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
        }
    },to:url,headers: headersKEY)
    { (result) in
        switch result {
        case .success(let upload, _, _):
            upload.uploadProgress(closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
                print("uploding\(progress)")
                let total = progress.totalUnitCount
                let obt  = progress.completedUnitCount
                let per = Double(obt) / Double(total) * 100
                let perint = Int(per)
                showProgress(text: "\(perint)" + " " + "%")
            })
            upload.responseJSON{ response in
                
                print(response)
                print("done")
                let a = JSON(response.result.value)
                print(a)
                dismissProgress()
                completionHandler(a, false)
                
            }
        case .failure(let encodingError):
            print(encodingError)
            let a = JSON()
            dismissProgress()
            completionHandler(a, true)
        }
    }
    
}

func goOneStepBack(msg:String, sender:UIViewController)
{
    
    let myAlert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
    
    let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
        (_)in
        
        sender.navigationController?.popViewController(animated: true)
    })
    myAlert.addAction(OKAction)
    sender.present(myAlert, animated: true, completion: nil)
}

