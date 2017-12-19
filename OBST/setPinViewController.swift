//
//  setPinViewController.swift
//  OBST
//
//  Created by Amit Dhadse on 18/12/17.
//  Copyright © 2017 Amit Dhadse. All rights reserved.
//

import UIKit


class setPinViewController: UIViewController,GSPasswordInputViewDelegate {

    @IBOutlet var pinView         : GSPasswordInputView!
    @IBOutlet var confirmPinView  : GSPasswordInputView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.commonIntilization()
        // Do any additional setup after loading the view.
    }
    
    func commonIntilization()
    {
        pinView.numberOfDigit = 4
        pinView.delegate = self
        pinView.layer.cornerRadius = 5
        pinView.layer.borderWidth = 1
        pinView.borderColor = UIColor.red
        pinView.clipsToBounds = true
        
        
        confirmPinView.numberOfDigit = 4
        confirmPinView.delegate = self
        confirmPinView.layer.cornerRadius = 5
        confirmPinView.layer.borderWidth = 1
        confirmPinView.borderColor = UIColor.red
        confirmPinView.clipsToBounds = true

    }
    
    
    func didFinishEditing(with anInputView: GSPasswordInputView!, text aText: String!)
    {
        
    }
    
    
    @IBAction func submitButtonClicked()
    {
        //RegSucessIdentifier
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let conformotpVC = storyboard.instantiateViewController(withIdentifier: "RegSucessIdentifier")
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
