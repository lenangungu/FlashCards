//
//  FlashcardViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/17/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit


class FlashcardViewController: UIViewController {
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
 
    @IBOutlet weak var nextPageButton: UIBarButtonItem!
    @IBOutlet weak var answerTextView: UITextView!
    
    var card: Flashcard?
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Not passing anything back to the view controller so no reference to it needed
//        let folderTitleViewController = segue.destinationViewController as! FolderTitleViewController
        
        let identifier = segue.identifier
        
        if identifier == "Save"
        {
            // REVIEW !!!
            
            if let card = card{
                let newCard = Flashcard()
                newCard.question = questionTextView.text ?? " "
                newCard.answer = answerTextView.text ?? " "
                
//       Debugging step: print("\(newCard.answer) \(newCard.question)")
                
                RealmHelper.updateCard(card, newCard: newCard)
            }
            
//                // Will never be the case because we are always passing a  card since we save it when we create it
//                else{
//                let emptyCard = Flashcard()
//                emptyCard.question = questionTextView.text ?? " "
//                emptyCard.answer = answerTextView.text ?? " "
//                RealmHelper.addCard(emptyCard)
//                
//                }
           
            print(" Flashcard saved")
            
            // Folder already has cards because we append them as we create them...no need to retrieve them
//        folderTitleViewController.folder?.cardArray = RealmHelper.retrieveFlashcard()
         
            }
      
            
        }
  
   
   
 
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // if card != nil ....
        if let card = card {
            questionTextView.text = card.question
            answerTextView.text = card.answer
            
        }
        else{
            // Setting fields of newCards to empty strings
            questionTextView.text = " "
            answerTextView.text = " "
    
        }
    
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


