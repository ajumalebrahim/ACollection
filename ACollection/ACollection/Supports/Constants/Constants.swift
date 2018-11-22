//
//  Constants.swift
//  ACollection
//
//  Created by Ajumal Ebrahim on 11/22/18.
//  Copyright © 2018 Ajumal Ebrahim. All rights reserved.
//

import Foundation

struct APPURL {
    private struct Domains {
        static let Dev = ""
        static let Live = ""
    }
    private  static let BaseURL = Domains.Dev
    
    static var getWall: String {
        return "http://pastebin.com/raw/wgkJgazE"
    }
}
