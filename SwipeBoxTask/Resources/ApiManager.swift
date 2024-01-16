//
//  ApiManager.swift
//  SwipeBoxTask
//
//  Created by Ali Sher on 14/01/2024.
//

import Foundation
import Alamofire

protocol ApiManagerProtocol {
    
    func onError(msg : String, name: String)
    func onSuccess(data : NSDictionary, name: String)
}


class ApiManager: NSObject {
    
    var delegate: Any? = nil
    var protocolmain_Catagory : ApiManagerProtocol! = nil
    static let sharedInstance = ApiManager()
    
    
    func WebService1(url: String, parameter: Parameters?, method: HTTPMethod, encoding: URLEncoding, _ onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void) {
        
        var headers: HTTPHeaders = [:]
        let params = parameter
        
        headers = ["Content-Type": "application/json",
                   "Accept": "text/html"]
        
        AF.request(url, method: method, parameters: params, encoding: encoding, headers: headers).responseData(completionHandler: { response in
            switch response.result {
            case .success( _):
                
                print(response)
                guard let data = response.data else { return }
                onSuccess(data)
                
                
            case .failure(let error):
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
                print("===========================\n\n")
                
                print("Failure\(error.localizedDescription)")
                onFailure(error)
            }
        })
    }
}
