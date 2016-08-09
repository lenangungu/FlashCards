//
//  Folder.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/19/16.
//  Copyright © 2016 Make School. All rights reserved.
//
//
import Foundation
import RealmSwift

class Folder: Object  {
    
    // have to be dynamic to connect the properties to Realm
    dynamic var title = "New folder"
    dynamic var dateAdded = NSDate()
    // array to hold the cards RLLArray(objectClassName: "Alias")
    
    var cardArray = List<Flashcard>()

}