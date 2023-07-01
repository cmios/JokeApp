//
//  ApiService.swift
//  DailyJoke
//
//  Created by CM on 28/06/23.
//

import Foundation

class ApiServiceClass{


    func GetNewJokes()  async throws -> String  {
        
        if !Reachability.isConnectedToNetwork(){
           
            throw JokeFetcherError.NoInternetConnection
        }
        guard let url = URL(string: "https://geek-jokes.sameerkumar.website/api") else {
            return ""
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data,_) = try await URLSession.shared.data(from:url)
        
              
        let decodedData = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
          

           
               
        return decodedData as? String ?? ""
    }
}
