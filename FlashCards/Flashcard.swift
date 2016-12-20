//
//  Flashcard.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/17/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import RealmSwift

class Flashcard: Object {
    
    // have to be dynamic to connect the properties to Realm
    dynamic var question = ""
    dynamic var answer = ""
    dynamic var correct = 0
    dynamic var wrong = 0
    dynamic var quiz = 0
    var index: Int?
  
}