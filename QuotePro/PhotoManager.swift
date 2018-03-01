//
//  PhotoManager.swift
//  QuotePro
//
//  Created by Eric Gregor on 2018-02-28.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

import Foundation
import Nuke

struct PhotoManager {
    
    static func generatePhoto(completionHandler: @escaping (UIImage) -> Void) {
        let url = NSURL(string: "http://lorempixel.com/200/300")
        var request = Request(url: url! as URL)
        request.memoryCacheOptions.writeAllowed = false
        Manager.shared.loadImage(with: request, completion: { response in
            let image = response.value
            completionHandler(image!)
            
        })
    }
    
}
