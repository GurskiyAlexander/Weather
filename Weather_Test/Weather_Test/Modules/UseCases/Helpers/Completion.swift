//
//  Completion.swift
//  LuxeCleaner
//
//  Created by Nikita Arshinov on 11.02.24.
//

import Foundation

public typealias Completion<ResponseType> = (Result<ResponseType>) -> Void
