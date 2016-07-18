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
    @IBOutlet weak var answerTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet var newFlashcardView: UIView!
    @IBOutlet var existingFlashcardView: UIView!
    
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
        
        let identifier = segue.identifier
        if identifier == "Save"
        {
            // REimplement !!!  
            
            if let card = card{
                let newCard = Flashcard()
                newCard.question = card.question ?? " "
                newCard.answer = card.answer ?? " "
                // update the newCard in the card.
            }
                else{
                let emptyCard = Flashcard()
                emptyCard.question = card!.question
                emptyCard.answer = card!.answer
                // add the empty card to
                }
            }
            
        }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // if there is an existing flashcard, load view 2 , else, load view 1
        
        if card != nil{
          self.view.addSubview(existingFlashcardView)
        }
        else{
            self.view.addSubview(newFlashcardView)
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


