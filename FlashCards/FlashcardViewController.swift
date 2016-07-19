//
//  FlashcardViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/17/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit


class FlashcardViewController: UIViewController {
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var nextCardButton: UIButton!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    
    
    var card: Flashcard?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let folderTitleViewController = segue.destinationViewController as! FolderTitleViewController
        let identifier = segue.identifier
        if identifier == "Save"
        {
            // REimplement !!!  
            
            if card != nil{
                let newCard = Flashcard()
                newCard.question = questionTextView.text ?? " "
                newCard.answer = answerTextView.text ?? " "
                RealmHelper.updateCard(card!, newCard: newCard)
            }
                else{
                let emptyCard = Flashcard()
                emptyCard.question = questionTextView.text ?? " "
                emptyCard.answer = questionTextView.text ?? " "
                RealmHelper.addCard(emptyCard)
              
                }
            print(" Flashcard saved")
            folderTitleViewController.cards = RealmHelper.retrieveFlashcard()
            }
      
            
        }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // if there is an existing flashcard, load view 2 , else, load view 1
        
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
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


