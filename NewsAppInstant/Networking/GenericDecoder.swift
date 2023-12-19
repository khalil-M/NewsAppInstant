//
//  AppDelegate.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation

public class GenericDecoder {
    public static func decodeResult<T: DTO> (result: HTTPClientResult) -> Swift.Result<T, NetworkingServiceError> {
        
        if let response = result.response, let urlResponse = response.response {
            print(urlResponse)
            
            print("\n\nResponse HTTP Headers:\n")
            for (key, value) in response.headers.allValues() {
                print(key, value)
            }
            
            if response.statusCode == 400 {
                return .failure(.badRequest)
            }
            
            if response.statusCode == 401 {
                return .failure(.notAuthorized)
            }
            
            if response.statusCode != 200 {
                return .failure(.invalidData)
            }
        }  else {
            return .failure(.connectivity)
        }
        
        if let data = result.data {
            let decoder = JSONDecoder()
            do { 
                let jsonStr = String(decoding: data, as: UTF8.self)
                print(jsonStr)
                let userData = try decoder.decode(T.self, from: data)
                print(userData.description)
                return .success(userData)
            } catch {
                print(error)
                return .failure(.invalidData)
            }
        } else {
            return .failure(.invalidData)
        }
    }
}
