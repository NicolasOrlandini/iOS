//
//  Event.swift
//  DAM-TD3
//
//  Created by LEON Valentin on 23/01/2017.
//  Copyright © 2017 LEON Valentin. All rights reserved.
//

import Foundation
import SWXMLHash

class Event: XMLIndexerDeserializable{
    var id : String = ""
    var date : String = ""
    var name : String = ""
    //var desc : String = "" //à voir si on le garde ou pas...
    var flyer : String = ""

    init( id: Int, date: NSDate, name: String, flyer: String) {
        self.id = id
        self.date = date
        self.name = name
        self.flyer = flyer
    }
}
