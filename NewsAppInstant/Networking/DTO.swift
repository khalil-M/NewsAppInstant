//
//  AppDelegate.swift
//  NewsAppInstant
//
//  Created by User on 19/12/2023.
//

import Foundation

public protocol DTO: Codable, CustomStringConvertible, Hashable {
    
}

extension Array: DTO where Element: DTO
{
    
}

