//
//  AppDelegate.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation

public enum NetworkingServiceError: Swift.Error {
    case connectivity
    case invalidData
    case badRequest
    case notAuthorized
}
