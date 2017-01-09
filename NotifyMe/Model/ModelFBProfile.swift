//
//  ModelFBProfile.swift
//  NotifyMe
//
//  Created by Narongsak kongpan on 1/9/2560 BE.
//  Copyright © 2560 Narongsak kongpan. All rights reserved.
//

import Foundation
import ObjectMapper

class ModelFBProfile:Mappable {
    var id = 0;
    var name:String? = nil;
    var email:String? = nil;
    
    required convenience init?(map: Map) {
        self.init();
    }
    
    func mapping(map: Map) {
        id <- map["id"];
        name <- map["name"];
        email <- map["email"];
    }
}
