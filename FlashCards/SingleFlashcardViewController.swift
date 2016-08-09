//
//  SingleFlashcardViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 8/5/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class SingleFlashcardViewController: UIViewController {

    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!

    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var card: Flashcard?
    var folder: Folder?
    var cardArray: List<Flashcard>?
    var index = 0
    
    @IBAction func revealAnswerAction(sender: AnyObject) {
        UIView.transitionWithView(self.questionTextView, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: nil, completion: {(finished: Bool) -> () in
            
            
            self.answerTextView.alpha = 1
          
            })
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Creating card color and reseting the answer text view color
        let LbeigeColor = UIColor(red: 245.0/255.0, green: 255.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        
        answerTextView.backgroundColor = LbeigeColor
      
    
        questionTextView.text = card!.question
        answerTextView.text = card!.answer
        answerTextView.alpha = 0
        print("You got \(card!.correct) correct attempts and \(card!.wrong) wrong attempts")
    
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // REVIEW!!!!
        
        let identifier = segue.identifier
        if identifier == "editFlashcard"
        {
            let editFlashcardViewController = segue.destinationViewController as! FlashcardViewController
            
            editFlashcardViewController.folder = folder
            editFlashcardViewController.card = card
        }
    }
    
    @IBAction func deleteButtonAction(sender: AnyObject) {
        
        let questionController = UIAlertController(title: "Delete card?", message: nil, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        questionController.addAction(cancelAction)
        
        //        collectionView(foldersCollectionView, didSelectItemAtIndexPath:(sender.view as! FolderCollectionViewCell).indPath! )
        
        
        
        
        let deleteAction = UIAlertAction(title: "Delete", style: .Default){(action) in
            
            
            RealmHelper.deleteCard(self.card!)
            
            
            self.navigationController?.popViewControllerAnimated(true)
            
            
        }
        questionController.addAction(deleteAction)
        self.presentViewController(questionController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
