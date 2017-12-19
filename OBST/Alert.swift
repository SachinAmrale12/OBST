//
//  Alert.swift
//  OBST
//
//  Created by Sachin Amrale on 18/12/17.
//  Copyright © 2017 Amit Dhadse. All rights reserved.
//

import Foundation

extension UIViewController{
    
    func SingleButtonAlert(errorMessage: String,buttonTitle: String,alertTitle: String)
    {
        MTPopUp(frame: self.view.frame).show(complete: { (index) in
            
        },
                                             view: self.view,
                                             animationType: MTAnimation.ZoomIn_ZoomOut,
                                             strMessage: errorMessage,
                                             btnArray: [buttonTitle],
                                             strTitle: alertTitle)
    }
}

extension String {
    
    func stringReplace() -> String
    {
        return self.replacingOccurrences(of: "/", with: ":~:")
    }
}
