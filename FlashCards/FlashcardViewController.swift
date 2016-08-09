//
//  NewFlashcardViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/28/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class FlashcardViewController: UIViewController {
    

    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    
 //   @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var card: Flashcard?
    var folder: Folder?
//    var folderVC : UIViewController!
    
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
                folder?.cardArray.append(newCard)}
            //        folder?.cardArray.append(newCard)
            //
            RealmHelper.addCard(newCard)
        }
       
        navigationController?.popViewControllerAnimated(true)
        
        
    }
        
    @IBAction func cancelButtonAction(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
//    @IBAction func deleteButtonAction(sender: AnyObject) {
//        
//        let questionController = UIAlertController(title: "Delete card?", message: nil, preferredStyle: .Alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        
//        questionController.addAction(cancelAction)
//        
//        //        collectionView(foldersCollectionView, didSelectItemAtIndexPath:(sender.view as! FolderCollectionViewCell).indPath! )
//        
//        
//        
//        
//        let deleteAction = UIAlertAction(title: "Delete", style: .Default){(action) in
//            
//            
//            RealmHelper.deleteCard(self.card!)
//           
//            
//            self.navigationController?.popViewControllerAnimated(true)
//            
//
//    }
//         questionController.addAction(deleteAction)
//         self.presentViewController(questionController, animated: true, completion: nil)
       

  //  }
    
   
    
//    @IBAction func deleteCardAction(sender: AnyObject) {
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        // Dismiss keyboard when tapping 
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FlashcardViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        
//        let identifier = segue.identifier
//    
//    if identifier == "Save"
//    {
//    // REVIEW !!!
//    
//    if let card = card{
//    let newCard = Flashcard()
//    newCard.question = questionTextView.text
//        newCard.answer = answerTextView.text
//        RealmHelper.updateCard(card, newCard: newCard)}
//        
//    else{
//        let newCard = Flashcard()
//        newCard.question = questionTextView.text
//        newCard.answer = answerTextView.text 
//        let realm = try! Realm()
//                try! realm.write(){
//                   folder?.cardArray.append(newCard)}
////        folder?.cardArray.append(newCard)
////        
//         RealmHelper.addCard(newCard)
//        }
//
//        }
//
//    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
   
    // Setting fields of newCards to empty strings
        if let card = card{
    questionTextView.text = card.question
    answerTextView.text = card.answer
//            deleteButton.enabled = true
        }
//        else {deleteButton.enabled = false
//       }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
