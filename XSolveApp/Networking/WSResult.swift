//
//  WSResult.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 05.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

enum WSResult<T, E> where E: Error {
    case success(T)
    case failure(E)
}
