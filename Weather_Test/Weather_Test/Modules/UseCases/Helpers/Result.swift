//
//  Result.swift
//  LuxeCleaner
//
//  Created by Nikita Arshinov on 11.02.24.
//

import Foundation

public enum Result<T> {
    case value(T)
    case error(String)
}
