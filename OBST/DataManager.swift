//
//  DataManager.swift
//  OBST
//
//  Created by Sachin Amrale on 16/12/17.
//  Copyright © 2017 Amit Dhadse. All rights reserved.
//

import UIKit

class DataManager: NSObject {

    class func SharedInstance() -> DataManager{
        struct Static {
            //Singleton instance. Initializing Data manager.
            static let sharedInstance = DataManager()
        }
        /** @return Returns the default singleton instance. */
        return Static.sharedInstance
    }
    
}
