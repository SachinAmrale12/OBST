//
//  OTPViewController.swift
//  OBST
//
//  Created by Amit Dhadse on 18/12/17.
//  Copyright © 2017 Amit Dhadse. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {

    @IBOutlet var checkBox                  : Checkbox!
    @IBOutlet var otpTextfield              : UITextField!
    @IBOutlet var validateOTPButton         : UIButton!
    @IBOutlet var resendOTP                 : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.commonIntilization()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func commonIntilization()
    {
        checkBox.layer.borderWidth = 1.0
        checkBox.layer.borderColor = UIColor(red: (232.0/255.0), green: 63.0/255.0, blue: 67.0/255.0, alpha: 1.0).cgColor
        checkBox.borderStyle = .square
        checkBox.checkmarkStyle = .tick
        checkBox.borderWidth = 2
        checkBox.uncheckedBorderColor = UIColor(red: (232.0/255.0), green: 63.0/255.0, blue: 67.0/255.0, alpha: 1.0)
        checkBox.checkedBorderColor = UIColor(red: (232.0/255.0), green: 63.0/255.0, blue: 67.0/255.0, alpha: 1.0)
        checkBox.checkmarkSize = 0.8
        checkBox.checkmarkColor = UIColor(red: (232.0/255.0), green: 63.0/255.0, blue: 67.0/255.0, alpha: 1.0)
        
        
        
        self.otpTextfield.layer.borderColor = UIColor(red: (232.0/255.0), green: 63.0/255.0, blue: 67.0/255.0, alpha: 1.0).cgColor
        self.otpTextfield.layer.borderWidth = 1
        self.otpTextfield.layer.cornerRadius = 5
        
        
        self.validateOTPButton.layer.cornerRadius = 5

        
        let Attributes : [String: Any] = [
            NSFontAttributeName : UIFont.systemFont(ofSize: 15),
            NSForegroundColorAttributeName : UIColor(red: (232.0/255.0), green: 63.0/255.0, blue: 67.0/255.0, alpha: 1.0),
            NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue]
        
        
        let attributeString = NSMutableAttributedString(string: "Re-send OTP",
                                                        attributes: Attributes)
        self.resendOTP.setAttributedTitle(attributeString, for: .normal)
        
        
        //checkBox.addTarget(self, action: #selector(checkMarkValueChanged(sender:)), for: .valueChanged)
    }
    
    @IBAction func validateButtonClicked()
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let conformotpVC = storyboard.instantiateViewController(withIdentifier: "setPinIdentifier")
        self.navigationController?.pushViewController(conformotpVC, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
