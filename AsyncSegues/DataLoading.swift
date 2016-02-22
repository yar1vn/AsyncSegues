//
//  DataLoading.swift
//  AsyncSegues
//
//  Created by Yariv Nissim on 2/22/16.
//  Copyright © 2016 Yariv Nissim. All rights reserved.
//

import UIKit

//
// MARK:- Data Loading
//

enum Errors: ErrorType {
    case ModelError
    case ImageError
}

extension Make {
    func loadModels(completion: (([Model]?, ErrorType?) -> Void)) {
        // simulate async call
        let seconds: UInt64 = 2
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            completion(self.models, nil)
        }
    }
    
    func loadImage(completion: ((UIImage?, ErrorType?) -> Void)) {
        guard let imageUrl = imageUrl else { completion(nil, Errors.ImageError); return }
        
        NSURLSession.sharedSession().dataTaskWithURL(imageUrl) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    completion(nil, Errors.ImageError)
                }
                return
            }
            NSOperationQueue.mainQueue().addOperationWithBlock {
                completion(image, nil)
            }
            }.resume()
    }
}