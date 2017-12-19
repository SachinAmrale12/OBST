//
//  RegistrationSuccessVC.swift
//  OBST
//
//  Created by Amit Dhadse on 19/12/17.
//  Copyright © 2017 Amit Dhadse. All rights reserved.
//

import UIKit

class RegistrationSuccessVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked()
    {
        //loginIdentifier
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let conformotpVC = storyboard.instantiateViewController(withIdentifier: "loginIdentifier")
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
