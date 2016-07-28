//
//  FlashcardViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/17/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import RealmSwift


class FlashcardViewController: UIViewController {
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var nextPageButton: UIBarButtonItem!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet var flashcardView: UIView!
    
    @IBOutlet weak var containerImage: UIImageView!
    @IBOutlet weak var placeholderTextField: UITextField!
    
    @IBOutlet weak var answerTextLabel: UILabel!
    
    var folder: Folder?
    
    var card: Flashcard?
    var cardArray: List<Flashcard>?
    var index: Int?
    
    @IBAction func answerSwipeAction(sender: AnyObject) {
        
        
        //animate the swipe
      
        placeholderTextField.alpha = 0
        containerImage.alpha = 0
        UIView.transitionWithView(self.containerImage, duration: 0.5, options: UIViewAnimationOptions.TransitionCurlUp, animations: nil, completion: nil)
        
        
        answerTextLabel.alpha = 0
        
    }
    
    
    @IBAction func swipeAction(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func fowardSwipeAction(sender: AnyObject) {
        
        
    }
  

    @IBAction func nextButtonAction(sender: AnyObject) {
        
//        // if there is still a card in the array, display the next card
        cardArray = folder?.cardArray
        let count = cardArray!.count
    
        index = index! + 1
       
        if count > 1 && index < count - 1
        {
            nextPageButton.enabled = true
            let nextCard = cardArray![index!]
        
            self.card = nextCard
        // Debug step 
            print("\(card!.question)")
        
          // Called viewWilAppear to relaod the view
           
        print("Next card")
        self.viewWillAppear(true)
        //        print ("\(count)")\
           

       }
            // if last card , arrow = done 
          
        
        else
        {
            nextPageButton.enabled = false
            
            
        }
//
        //{nextPageButton.enabled = false
            
       // nextPageButton.style = .Done  }
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
                 print(" Flashcard saved")
                
            }
            
            else {
                let newCard = Flashcard()
                newCard.question = questionTextView.text ?? " "
                newCard.answer = answerTextView.text ?? " "
                
                //       Debugging step: print("\(newCard.answer) \(newCard.question)")
                
                
                let realm = try! Realm()
                try! realm.write(){
                    folder!.cardArray.append(newCard)}
                
                RealmHelper.addCard(newCard)
                print(" Flashcard saved")
            }
            
        }
        
        
       
        }
    
    

   
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // Do any additional setup after loading the view.
    
    
    

        
            
//                // Will never be the case because we are always passing a  card since we save it when we create it
//                else{
//                let emptyCard = Flashcard()
//                emptyCard.question = questionTextView.text ?? " "
//                emptyCard.answer = answerTextView.text ?? " "
//                RealmHelper.addCard(emptyCard)
//                
//                }
        
            
            // Folder already has cards because we append them as we create them...no need to retrieve them
//        folderTitleViewController.folder?.cardArray = RealmHelper.retrieveFlashcard()
         
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
            
           // Alpha = 0 makes the answer text view accessible but .hidden does not, it just hides the element 
            
            containerImage.alpha = 0
            placeholderTextField.alpha = 0
            answerTextLabel.alpha = 0
            nextPageButton.enabled = false
            shareButton.enabled = false

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


