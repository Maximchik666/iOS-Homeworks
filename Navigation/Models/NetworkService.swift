//
//  NetworkManager.swift
//  Navigation
//
//  Created by Maksim Kruglov on 23.11.2022.
//

import Foundation

struct NetworkService {

    static func request (forConfiguration: AppConfiguration) {
        
        let urlSession = URLSession.shared
        
        if let url = URL(string: forConfiguration.rawValue) {
            let request = URLRequest(url: url)
            
            let task = urlSession.dataTask(with: request, completionHandler: {data, responce, error in
                
                if let unwrappedData = data {
                   // print("Unwrapped Data: \(String(data: unwrappedData, encoding: .utf8) ?? "Error(((")")
                }
               
                if let unwrappedResponce = responce as? HTTPURLResponse {
                  //  print("AllHeadersField: \(unwrappedResponce.allHeaderFields)")
                  //  print("StatusCode: \(unwrappedResponce.statusCode)")
                }
                
                if let unwrappedError = error {
                   // print("Error Code: \(unwrappedError.localizedDescription)")
                } else {
                   // print("No Errors")
                }

            })
            
            task.resume()
        }
    }
}

