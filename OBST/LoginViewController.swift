//
//  LoginViewController.swift
//  OBST
//
//  Created by Amit Dhadse on 19/12/17.
//  Copyright © 2017 Amit Dhadse. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,GSPasswordInputViewDelegate {

    @IBOutlet var pinView : GSPasswordInputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pinView.numberOfDigit = 4
        pinView.delegate = self
        pinView.layer.cornerRadius = 5
        pinView.layer.borderWidth = 1
        pinView.borderColor = UIColor.red
        pinView.clipsToBounds = true

        // Do any additional setup after loading the view.
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
