//
//  ViewController.swift
//  OBST
//
//  Created by Amit Dhadse on 12/12/17.
//  Copyright © 2017 Amit Dhadse. All rights reserved.
//

import UIKit
import ReachabilitySwift

class ViewController: UIViewController,UITextFieldDelegate {

    //MARK: View Outlets
    
    @IBOutlet weak var mobileNumberTextField    : UITextField!
    @IBOutlet weak var submitButton             : UIButton!
    @IBOutlet weak var loaderView               : UIView!
    @IBOutlet weak var loaderBgView             : UIView!
    @IBOutlet var employeeCodeTextField         : UITextField!
    
    //MARK: Instance Variables
    
    var loader                                  : LiquidLoader! = nil
    let networkReachability                     = Reachability()
    
    //MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInitialization()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.employeeCodeTextField.text = "TID0052"
        self.mobileNumberTextField.text = "919406764021"
    }
    
    func commonInitialization()
    {
       
        loaderBgView.isHidden = true
       
        self.submitButton.layer.borderColor = UIColor(red: (232.0/255.0), green: 63.0/255.0, blue: 67.0/255.0, alpha: 1.0).cgColor
        self.submitButton.layer.borderWidth = 1
        self.submitButton.layer.cornerRadius = 5
        
        
        self.employeeCodeTextField.layer.borderColor = UIColor(red: (232.0/255.0), green: 63.0/255.0, blue: 67.0/255.0, alpha: 1.0).cgColor
        self.employeeCodeTextField.layer.borderWidth = 1
        self.employeeCodeTextField.layer.cornerRadius = 5
        
        self.employeeCodeTextField.attributedPlaceholder = NSAttributedString(string: " Employee Code ",
                                                                              attributes: [NSForegroundColorAttributeName: UIColor(red: (251.0/255.0), green: 217.0/255.0, blue: 216.0/255.0, alpha: 1.0)])
        
        self.mobileNumberTextField.layer.borderColor = UIColor(red: (232.0/255.0), green: 63.0/255.0, blue: 67.0/255.0, alpha: 1.0).cgColor
        self.mobileNumberTextField.layer.borderWidth = 1
        self.mobileNumberTextField.layer.cornerRadius = 5
        
        self.mobileNumberTextField.attributedPlaceholder = NSAttributedString(string: "  Mobile eg. 91XXXXXXXXXX",
                                                               attributes: [NSForegroundColorAttributeName: UIColor(red: (251.0/255.0), green: 217.0/255.0, blue: 216.0/255.0, alpha: 1.0)])
        
        loader = LiquidLoader(frame: loaderView.bounds, effect: .growLine, color: UIColor(red: (232.0/255.0), green: 63.0/255.0, blue: 67.0/255.0, alpha: 1.0), numberOfCircle: 6, duration: 2.5, growColor: UIColor(red: (251.0/255.0), green: 220.0/255.0, blue: 222.0/255.0, alpha: 1.0))
        self.loaderView.addSubview(loader)
        
    }
    
    //MARK: Button Action
    
    @IBAction func submitButtonClicked(_ sender: UIButton)
    {
        
        if mobileNumberTextField.text?.isEmpty == true && employeeCodeTextField.text?.isEmpty == true
        {
            self.SingleButtonAlert(errorMessage: "Please Enter Employee Code and Mobile Number", buttonTitle: "OK", alertTitle: "Error")
            return
        }
        if employeeCodeTextField.text?.isEmpty == true
        {
            self.SingleButtonAlert(errorMessage: "Please Enter Employee Code", buttonTitle: "OK", alertTitle: "Error")
            return
        }
        if mobileNumberTextField.text?.isEmpty == true
        {
            self.SingleButtonAlert(errorMessage: "Please Enter Mobile Number", buttonTitle: "OK", alertTitle: "Error")
            return
        }
        
        if (networkReachability?.isReachable)!
        {
            let employeeCode = employeeCodeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            print(employeeCode!)
            let mobileNo = mobileNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            print(mobileNo!)
            
            JNKeychain.saveValue(employeeCode, forKey: "EmpID")
            JNKeychain.saveValue(mobileNo, forKey: "mobileNumber")
            
            let encryptedEmpID = AESCrypt.encrypt(employeeCodeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), password: DataManager.SharedInstance().getGlobalKey()).stringReplace()
            let encryptedMobileNumber = AESCrypt.encrypt(mobileNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), password: DataManager.SharedInstance().getGlobalKey()).stringReplace()
            let encryptedClientID = AESCrypt.encrypt("obst", password: DataManager.SharedInstance().getKeyForEncryption()).stringReplace()
            let encryptedClientSecret = AESCrypt.encrypt("1211@obst", password: DataManager.SharedInstance().getKeyForEncryption()).stringReplace()
            
            JNKeychain.saveValue(encryptedClientID, forKey: "encryptedClientID")
            JNKeychain.saveValue(encryptedClientSecret, forKey: "encryptedClientSecret")
            
            loaderBgView.isHidden = false
            loader.show()
            
            DataManager.getOTP(empID: encryptedEmpID, mobileNo: encryptedMobileNumber, clientId: encryptedClientID, clientSecret: encryptedClientSecret, completionClouser: { (isSuccessful, error, result) in
                
                self.loaderBgView.isHidden = true
                self.loader.hide()
                
                if isSuccessful
                {
                    print(result!)
                    if let jsonResult = result as? Dictionary<String, Any>
                    {
                        if let test = jsonResult["error"]
                        {
                            let str = test as! String
                            let error = AESCrypt.decrypt(str, password: DataManager.SharedInstance().getKeyForEncryption())
                            print(error!)
                            
                            if error == "NA"
                            {
                                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                                let conformotpVC = storyboard.instantiateViewController(withIdentifier: "OTPVC_Identifier")
                                self.navigationController?.pushViewController(conformotpVC, animated: true)
                            }
                            else
                            {
                                self.SingleButtonAlert(errorMessage: error!, buttonTitle: "OK", alertTitle: "Error")
                            }
                        }
                    }
                }
                else
                {
                    if let errorString = error
                    {
                        self.SingleButtonAlert(errorMessage: errorString, buttonTitle: "OK", alertTitle: "Error")
                    }
                }
            })
            
        }
        else
        {
            self.SingleButtonAlert(errorMessage: "Your Device is not Connected to \"Internet\"", buttonTitle: "OK", alertTitle: "Internet connection Error")
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

