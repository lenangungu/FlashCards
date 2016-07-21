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
    
    // Flashcard functions
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
    
    //Folder functions
   
    static func addFolder(folder: Folder) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(folder)
        }
    }
    static func deleteFolder(folder: Folder) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(folder)
        }
    }
    static func updateFolder(folderToBeUpdated: Folder, newFolder: Folder) {
        let realm = try! Realm()
        try! realm.write() {
            folderToBeUpdated.title = newFolder.title
            
        }
    }
    static func retrieveFolder() -> Results<Folder> {
        let realm = try! Realm()
        return realm.objects(Folder)
    }
    //static methods will go here
}