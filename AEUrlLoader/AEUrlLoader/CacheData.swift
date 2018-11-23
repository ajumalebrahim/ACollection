//
//  CacheData.swift
//  AEUrlLoader
//
//  Created by SpaceWax on 11/23/18.
//  Copyright © 2018 Ajumal Ebrahim. All rights reserved.
//

import Foundation


class CacheData {
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol!
    
    static let shared = CacheData()
    
    private init() {
        // make sure to purge cache on memory pressure
        
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
