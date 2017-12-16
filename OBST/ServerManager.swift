//
//  ServerManager.swift
//  OBST
//
//  Created by Sachin Amrale on 16/12/17.
//  Copyright © 2017 Amit Dhadse. All rights reserved.
//

import UIKit
import Alamofire

class ServerManager: NSObject {
    
    //  let domainName = "http://10.144.118.20:1919/iBus"
    let domainName = "http://103.93.44.141:1919/iBus"
    // let domainName = "https://ibus.idbibank.co.in/iBusV1"

    var afManager : SessionManager!
    
    
    class func SharedInstance() -> ServerManager
    {
        struct serverStuct
        {
            static let sharedInstance = ServerManager()
        }
        return serverStuct.sharedInstance
    }
    
    
    func SharedInstanceForManager() -> SessionManager
    {
        if afManager == nil
        {
            // let pathToCert = Bundle.main.path(forResource: "certificate", ofType: "cer")
            // let localCertificate:Data = Data(contentsOfFile: pathToCert!)!
            
            let filePath = Bundle.main.url(forResource: "certificate", withExtension: "cer")
            let stringPath = filePath?.absoluteString
            do
            {
                let localCertificate = try Data(contentsOf: URL(string: stringPath!)!)
                let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
                    certificates: [SecCertificateCreateWithData(nil, localCertificate as CFData)!],
                    validateCertificateChain: true,
                    validateHost: true
                )
                
                let serverTrustPolicies: [String: ServerTrustPolicy] =
                    [
                        "ibus.idbibank.co.in": serverTrustPolicy
                ]
                
                let config = URLSessionConfiguration.default
                config.timeoutIntervalForRequest = 90
                afManager = SessionManager(
                    configuration: config,
                    serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
                )
            }
            catch
            {}
            
            return afManager
        }
        else
        {
            return afManager
        }
        
    }
    
    
    func webServiceCall(url :String,completionClouser :@escaping (_ isSuccessful: Bool,_ error: String?,_ result: Any?) -> Void)
    {
        
        Alamofire.request(
            url,
            method: .get,
            parameters: nil)
            .validate()
            .responseJSON{
                (response) in
                if response.result.error == nil
                {
                    let status = response.response?.statusCode
                    print(status as Any)
                    
                    if response.result.isSuccess
                    {
                        do {
                            let dictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                            
                            completionClouser(response.result.isSuccess,nil,dictionary)
                        }
                        catch
                        {}
                        return
                    }
                    else
                    {
                        completionClouser(response.result.isSuccess,response.error as? String,nil)
                    }
                }
                else
                {
                    let status = response.response?.statusCode
                    print(status as Any)
                    if status == 401
                    {
                        completionClouser(response.result.isSuccess,nil,nil)
                        
                        // it will call method when access token expired. method define in viewcontroller "poptoRootViewController"
                        let notificationName = Notification.Name("NotificationIdentifier")
                        NotificationCenter.default.post(name: notificationName, object: nil)
                        
                    }
                    else
                    {
                        completionClouser(response.result.isSuccess,response.error?.localizedDescription,nil)
                    }
                }
        }
        
    }
}
