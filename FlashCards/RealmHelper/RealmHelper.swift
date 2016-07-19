//
//  RealmHelper.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/18/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static func doSomething() {
        
    }
    static func addCard(card: Flashcard) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(card)
        }
    }
    static func deleteCard(card: Flashcard) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(card)
        }
    }
    static func updateCard(cardToBeUpdated: Flashcard, newCard: Flashcard) {
        let realm = try! Realm()
        try! realm.write() {
            cardToBeUpdated.question = newCard.question
            cardToBeUpdated.answer = newCard.answer
            
        }
    }
    static func retrieveFlashcard() -> Results<Flashcard> {
        let realm = try! Realm()
        return realm.objects(Flashcard)
    }
    //static methods will go here
}