//
//  NetworkManager.swift
//  Arch
//
//  Created by Pratap SIngh on 14/04/21.
//

import Foundation

class NetworkManager {
    public static let main = NetworkManager()
    private init() {}
    private var session = URLSession(configuration: URLSessionConfiguration.default)
    
    /// this method will handle POST request
    /// - Parameters:
    ///   - url: URL
    ///   - params: params
    ///   - file: if there is any file to be uploaded
    ///   - fileType: mem type
    ///   - complition: complition
    func requestToServer(request: URLRequest, complition:@escaping(_ data: Data?, _ responce: URLResponse?, _ error: Error?) -> Void){
        
        let task = session.dataTask(with: request) { (data, response, error) in
            complition(data, response, error)
        }
        task.resume()
    }
    
    func setMockSession(session: URLSession) {
        self.session = session
    }
}
