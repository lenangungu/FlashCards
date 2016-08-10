//
//  FlashcardViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/17/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import RealmSwift


class QuizFlashcardViewController: UIViewController {
   
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var skipButton: UIButton!
   
    @IBOutlet weak var correctButton: UIButton!
    
    @IBOutlet weak var wrongButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
   
    
    var card: Flashcard?
    var folder: Folder?
    var cardArray: List<Flashcard>?
    var quizCardArray: List<Flashcard>?
//    var ll : [List<Flashcard>] = []
    
    var index = 0
   let LbeigeColor = UIColor(red: 245.0/255.0, green: 255.0/255.0, blue: 198.0/255.0, alpha: 1.0)
    
    
    
   // var wrong_rightIndex: Int?
    
    
    @IBAction func shareAction(sender: AnyObject) {
        let activityVC = UIActivityViewController(activityItems: [cardArray!] , applicationActivities: nil)
        
        // Excluding activities not needed
        //            activityVC.excludedActivityTypes = [UIActivityTypePostToTwitter,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo]
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    //        else {shareButton.enabled = false}

    

    @IBAction func revealAnswerAction(sender: AnyObject) {
       
       // questionTextView.alpha = 0

        UIView.transitionWithView(self.questionTextView, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: nil, completion: {(finished: Bool) -> () in
            
            
        self.answerTextView.alpha = 1
        self.correctButton.alpha = 1
        self.wrongButton.alpha = 1
        self.skipButton.alpha = 0})

           // answerTextView.alpha = 1
        //questionTextView.alpha = 0
        
    }
   
    @IBAction func skipButtonAction(sender: AnyObject) {
      
        quizCardArray = folder?.quizCardArray
       // cardArray = folder?.cardArray
        
        let count = quizCardArray!.count
        //let count = cardArray!.count
     
     //  let rand = Int(arc4random_uniform(UInt32(count - 1) + 1))
    
        print(rand)

        
    //    loop = loop + 1
        
       // index = index + rand
        print("index is \(index)")
       index = index + 1
        print ("count is \(count)")
        
//        if count > 1 && index < count
            if count > 1 && index < count
        {
            skipButton.enabled = true
            
            let nextCard = quizCardArray![index]
            //let nextCard = cardArray![index]
            self.card = nextCard
            // Debug step
            print("\(card!.question)")
            
            // Called viewWilAppear to relaod the view
            
            print("Next card")
            self.viewWillAppear(true)
            //        print ("\(count)")\
            
            
        }
            // if last card , arrow = done
            
        //if loop == (count - 1)
        if index == (count - 1)
           
        { skipButton.alpha = 0
           
            //skipButton.enabled = false
           // skipButton.backgroundColor = UIColor.grayColor()
        }
        
        
       
    }
    
    
    
    @IBAction func correctButtonAction(sender: AnyObject) {
      //  quizCardArray = folder?.quizCardArray
       
        answerTextView.backgroundColor = UIColor.greenColor()
        
        let realm = try! Realm()
        try! realm.write() {
            card?.correct += 1
        }
    
       // cardArray = (folder?.cardArray)
        
        //let count = cardArray!.count
         let count = quizCardArray!.count
        // generate randomw numbers from 1 to highest index - 1
        
        index = index + 1
        
        if count > 1 && index < count
    {
       
        correctButton.enabled = false
        wrongButton.enabled = false
    
        let nextCard = quizCardArray![index]
        //let nextCard = cardArray![index]
        self.card = nextCard
        
        performSelector(#selector(viewWillAppear), withObject: view, afterDelay: 0.5)
        
      


    }
        else if index == (count)
        {
            correctButton.alpha = 0
            wrongButton.alpha = 0
           // quizCardArray = cardArray
            
            answerTextView.alpha = 0
            questionTextView.alpha = 0
            doneButton.alpha = 1
            
            print("wrong array is \( folder!.cardArray)")
            print("quizArray rest: \(quizCardArray)")
            
        }
       
    }
    @IBAction func wrongButtonAction(sender: AnyObject) {
       
        //quizCardArray = folder?.quizCardArray
        
//        let realm = try! Realm()
//        try! realm.write() {
//            ll = toArray(List<Flashcard>)
        // add the card index to wrongs to increase how many times card shows up
        let realm = try! Realm()
        try! realm.write() {
        quizCardArray!.append(card!)
           
        }
        answerTextView.backgroundColor = UIColor.redColor()
        
     //   let realm = try! Realm()
        try! realm.write() {
            card?.wrong += 1
        }
        
       // cardArray = folder?.cardArray
        //let count = cardArray!.count
         let count = quizCardArray!.count
        index = index + 1
        
        
        if count > 1 && index < count
    {
        
        correctButton.enabled = false
        wrongButton.enabled = false
        
        let nextCard = quizCardArray![index]
//         let nextCard = cardArray![index]
         self.card = nextCard
        
         performSelector(#selector(viewWillAppear), withObject: view, afterDelay: 0.5)
        
       
    }
        // Count will keep on increasing if you get a question wrong - Quiz will never end on a question gotten wrong
//        else if index == (count)
//        {
//            correctButton.alpha = 0
//            wrongButton.alpha = 0
//            print(quizCardArray)
//          //  quizCardArray = cardArray
//            answerTextView.tintColor = UIColor.redColor()
//            answerTextView.textColor = UIColor.redColor()
//            doneButton.alpha = 1
//            
//            print("wrong array is \( folder!.cardArray)")
//            print("quizArray rest: \(quizCardArray)")
//            
//        }
        
      
        }
    
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        print("Quiz done")
        navigationController?.popToRootViewControllerAnimated(true)
    }
        
    // Was for completed button action
//        cardArray = folder?.cardArray
//        let count = cardArray!.count
//        
//        index = index + 1
//        
//        
//        if count > 1 && index < count
//        {
//            skipButton.enabled = true
//            let nextCard = cardArray![index]
//            card?.correct += 1
//            self.card = nextCard
//            // Debug step
//            print("\(card!.question)")
//            
//            // Called viewWilAppear to relaod the view
//            
//            print("Next card")
//            self.viewWillAppear(true)
//            //        print ("\(count)")\
//            
//            
//            
//        }
//        if index == (count)
//        {
//            correctButton.enabled = false
//            
//        }
//        
//      
//    }
//    func toArray<Flashcard>(ofType: Flashcard.Type) -> [Flashcard] {
//        var array = [Flashcard]()
//        for i in quizCardArray! {
//            if let result = i as? Flashcard {
//                array.append(result)
//            }
//        }
//        
//        return array
//    }

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
        doneButton.alpha = 0
        print(quizCardArray)
        // Creating card color and reseting the answer text view color
        
        answerTextView.backgroundColor = LbeigeColor
        correctButton.enabled = true
        wrongButton.enabled = true
        
        correctButton.alpha = 0
        wrongButton.alpha = 0
        skipButton.alpha = 1
//        
//        cardArray = folder?.cardArray
//        let count = cardArray!.count
        quizCardArray = folder?.quizCardArray
        let count = quizCardArray!.count
        if count == 1
        {skipButton.enabled = false}
//       // let card = folder!.cardArray[0]
//        // if card != nil ....
////        if let card = card {
//        
            questionTextView.text = card!.question
            answerTextView.text = card!.answer
            answerTextView.alpha = 0
        print("You got \(card!.correct) correct attempts and \(card!.wrong) wrong attempts")
//
//        //}
//        else{
//            // Setting fields of newCards to empty strings
//            questionTextView.text = " "
//            answerTextView.text = " "
//        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//extension Results {
//    func toArray<Flashcard>(ofType: Flashcard.Type) -> [Flashcard] {
//        var array = [Flashcard]()
//        for i in 0 ..< count {
//            if let result = self[i] as? Flashcard {
//                array.append(result)
//            }
//        }
//        
//        return array
//    }
//}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


