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
    
    
    func getGlobalKey() -> String
    {
        return KeyCode.sharedInstance().getKey("2981012620", withMobile: "0262101892")
    }
    
    func getKeyForEncryption() -> String
    {
        let empID = JNKeychain.loadValue(forKey: "EmpID") as! String
        let mobileNo = JNKeychain.loadValue(forKey: "mobileNumber") as! String
        return KeyCode.sharedInstance().getKey(empID, withMobile: mobileNo)
    }
    
    class func getOTP(empID: String,mobileNo: String,clientId: String,clientSecret: String,completionClouser:@escaping (_ isSuccessful: Bool,_ error: String?,_ result: Any?) -> Void)
    {
        ServerManager.SharedInstance().getOTP(empID: empID, mobileNo: mobileNo, clientId: clientId, clientSecret: clientSecret) { (isSuccessful, error, result) in
            
            if isSuccessful
            {
                completionClouser(isSuccessful,nil,result)
            }
            else
            {
                completionClouser(isSuccessful,error,nil)
            }
        }
    }
}
