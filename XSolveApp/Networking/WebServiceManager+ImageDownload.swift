//
//  WebServiceManager+ImageDownload.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 01.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

//MARK: Downloading image from url
extension WebServiceManager {
    
    private func getDataFromUrl(url: URL?, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let url = url else {
            print("Getting data from url failed. Wrong format for URL address.")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    func downloadImage(from urlAddress: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlAddress) else { return }
        getDataFromUrl(url: url) { data, response, error in
            guard
                let data = data,
                error == nil
                else {
                    completion(nil)
                    return
            }
            completion(UIImage(data: data))
        }
    }
    
}
