//
//  ViewController.swift
//  OBST
//
//  Created by Amit Dhadse on 12/12/17.
//  Copyright © 2017 Amit Dhadse. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITextFieldDelegate {

    //MARK: View Outlets
    
    @IBOutlet weak var mobileNumberTextField    : UITextField!
    @IBOutlet weak var submitButton             : UIButton!
    @IBOutlet weak var loaderView               : UIView!
    @IBOutlet weak var loaderBgView             : UIView!
    
    //MARK: Instance Variables
    
    var loader                  : LiquidLoader! = nil
    
    //MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInitialization()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func commonInitialization()
    {
        loaderBgView.isHidden = true
        loaderBgView.backgroundColor = UIColor(red: (0.0/255.0), green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.7)
        self.submitButton.layer.borderColor = UIColor(red: (232.0/255.0), green: 63.0/255.0, blue: 67.0/255.0, alpha: 1.0).cgColor
        self.submitButton.layer.borderWidth = 1
        self.submitButton.layer.cornerRadius = 5
        
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
        loaderBgView.isHidden = false
        loader.show()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

