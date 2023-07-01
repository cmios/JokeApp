//
//  JokeModel.swift
//  DailyJoke
//
//  Created by CM on 28/06/23.
//

import Foundation

struct JokeModel:Codable{
    var arrJokeMsg :[String] = [""]
}

enum JokeFetcherError: Error {
        case invalidURL
        case missingData
        case  NoInternetConnection
    }
