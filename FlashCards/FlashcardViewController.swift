//
//  NewFlashcardViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/28/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class FlashcardViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    
    var card: Flashcard?
    var folder: Folder?
    
    @IBAction func saveButtonAction(sender: AnyObject) {
    
        if let card = card{
            let newCard = Flashcard()
            newCard.question = questionTextView.text
            newCard.answer = answerTextView.text
            RealmHelper.updateCard(card, newCard: newCard)}
            
        else{
            let newCard = Flashcard()
            newCard.question = questionTextView.text
            newCard.answer = answerTextView.text
            let realm = try! Realm()
            try! realm.write(){
                folder?.cardArray.append(newCard)
            }
            // This is for the duplicate of the cardArray
            try! realm.write(){
                folder?.quizCardArray.append(newCard)}
            //        folder?.cardArray.append(newCard)
            //
            RealmHelper.addCard(newCard)
        }
       
        navigationController?.popViewControllerAnimated(true)
        
        
    }
        
    @IBAction func cancelButtonAction(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
 
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Dismiss keyboard when tapping 
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FlashcardViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(FlashcardViewController.dismissKeyboard))
        view.addGestureRecognizer(pan)
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
   
    // Setting fields of newCards to empty strings
        if let card = card{
    questionTextView.text = card.question
    answerTextView.text = card.answer
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
