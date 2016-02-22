//
//  DataModels.swift
//  AsyncSegues
//
//  Created by Yariv Nissim on 2/19/16.
//  Copyright © 2016 Yariv Nissim. All rights reserved.
//

import UIKit

//
// MARK: - Data Models
//

struct Make {
    let name: String
    let models: [Model]
    
    var imageUrl: NSURL? {
        return NSURL(string: "https://s3-us-west-2.amazonaws.com/mobile-assets-pre-production/make-logo/285x180/fit/\(name.lowercaseString).png")
    }
}


struct Model {
    let name: String
}

