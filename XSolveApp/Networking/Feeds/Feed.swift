//
//  Feed.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 01.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

protocol Feed {
    var base: String { get }
    var path: String { get }
    func getURL() -> URL?
}
