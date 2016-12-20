//
//  FlashcardViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/17/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import RealmSwift
import Mixpanel


class QuizFlashcardViewController: UIViewController {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var wrongButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
  
    @IBOutlet weak var resultsTableView: UITableView!

    @IBOutlet weak var resultsQuestionLabel: UIButton!
    @IBOutlet weak var resultsAnswerLabel: UIButton!
    @IBOutlet weak var resultsWrongsLabel: UIButton!
    @IBOutlet weak var resultsBlackBand: UILabel!
    
    var card: Flashcard?
    var folder: Folder?
    var cardArray: List<Flashcard>?
    var quizCardArray: List<Flashcard>?

    var tryy: Int?
    var arrayOfIndex: [Int] = []
    var nextIndex = 0
    
    var quizArray: [Flashcard] = []
    var next = 0
    
    var index = 0
    let LbeigeColor = UIColor(red: 245.0/255.0, green: 255.0/255.0, blue: 198.0/255.0, alpha: 1.0)
    
    
    //
    //    @IBAction func shareAction(sender: AnyObject) {
    //        let activityVC = UIActivityViewController(activityItems: [cardArray!] , applicationActivities: nil)
    //
    //        // Excluding activities not needed
    //        //            activityVC.excludedActivityTypes = [UIActivityTypePostToTwitter,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo]
    //        self.presentViewController(activityVC, animated: true, completion: nil)
    //    }
    //    //        else {shareButton.enabled = false}
    //
    
    
    @IBAction func revealAnswerAction(sender: AnyObject) {
        
        UIView.transitionWithView(self.questionTextView, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: nil, completion: {(finished: Bool) -> () in
            
            
            self.answerTextView.alpha = 1
            self.correctButton.alpha = 1
            self.wrongButton.alpha = 1
            self.skipButton.alpha = 0})
        
    }
    
    func show () {
        doneButton.alpha = 0
        print(quizCardArray)
        // Creating card color and reseting the answer text view color
        
        answerTextView.backgroundColor = LbeigeColor
        correctButton.enabled = true
        wrongButton.enabled = true
        
        correctButton.alpha = 0
        wrongButton.alpha = 0
        skipButton.alpha = 1
        
        quizCardArray = folder?.quizCardArray
       let count = quizCardArray!.count
        if count == 1
        {skipButton.enabled = false
            skipButton.backgroundColor = UIColor.grayColor()}
        
        questionTextView.text = card!.question
        answerTextView.text = card!.answer
        answerTextView.alpha = 0
        print("You got \(card!.correct) correct attempts and \(card!.wrong) wrong attempts")
    }
    
    @IBAction func skipButtonAction(sender: AnyObject) {
        
        next = next + 1
        if quizArray.count > 0
        {
            skipButton.enabled = true
            
            let nextCard = quizArray[next]
            
            self.card = nextCard
            // Debug step
            print("\(card!.question)")
            
            
            print("Next card")
            
            doneButton.alpha = 0
            show()
            
        }
         if next == (quizArray.count - 1)
        {
            skipButton.enabled = false
            skipButton.backgroundColor = UIColor.grayColor()
        }
        
        
    }
    
    
    
    @IBAction func correctButtonAction(sender: AnyObject) {
        
        next = next + 1
        if next == (quizArray.count - 1)
        {
            skipButton.enabled = false
            skipButton.backgroundColor = UIColor.grayColor()
        }
        
        // nextIndex = nextIndex + 1
        answerTextView.backgroundColor = UIColor.greenColor()
        
        let realm = try! Realm()
        try! realm.write() {
            card?.correct += 1
        }
        
        
        if next < quizArray.count
        {
            
            //Here!!
            let nextCard = quizArray[next]
            
            correctButton.enabled = false
            wrongButton.enabled = false
            
            self.card = nextCard
            // quizArray.removeAtIndex((next - 1))
            
            
            performSelector(#selector(viewWillAppear), withObject: view, afterDelay: 0.5)
            
        }
        else if next == quizArray.count {
            correctButton.alpha = 0
            wrongButton.alpha = 0
            
            answerTextView.alpha = 0
            questionTextView.alpha = 0
            doneButton.alpha = 1
            
            //HERE!!
            // the result table will have all cards with their questions, answers, and number of wrongs - we then hve to set the number of wrongs to 0 each time the quiz is done
             UIView.transitionWithView(self.doneButton, duration: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: nil, completion: nil) 
            
            resultsTableView.alpha = 1
            resultsQuestionLabel.alpha = 1
            resultsAnswerLabel.alpha = 1
            resultsWrongsLabel.alpha = 1
            resultsBlackBand.alpha = 1
            
            let mixpanel: Mixpanel = Mixpanel.sharedInstance()
            mixpanel.track("Quiz done")
        }
        
        //}
        
        
    }
    
    
    
    @IBAction func wrongButtonAction(sender: AnyObject) {
       
       
        next = next + 1
        if next == (quizArray.count - 1)
        {
            skipButton.enabled = false
            skipButton.backgroundColor = UIColor.grayColor()
        }
        quizArray.append(card!)
        
        // arrayOfIndex.append(next)
        
        // next index is equal to the next element in the array of index
        // nextIndex = arrayOfIndex[next]
        // print(nextIndex)
        
        let realm = try! Realm()
        try! realm.write() {
            
        }
        answerTextView.backgroundColor = UIColor.redColor()
        
        try! realm.write() {
            card?.wrong += 1
        }
        
        
        print ("array has \(arrayOfIndex.count) elements")
        //Here!!
        //            if arrayOfIndex.count > 0
        //    {
        //
        //        correctButton.enabled = false
        //        wrongButton.enabled = false
        //
        //        let nextCard = quizCardArray![nextIndex]
        //
        //         self.card = nextCard
        //
        //         performSelector(#selector(viewWillAppear), withObject: view, afterDelay: 0.5)
        //
        //
        //    }
        if next < quizArray.count
        {
            
            correctButton.enabled = false
            wrongButton.enabled = false
            
            let nextCard = quizArray[next]
            
            self.card = nextCard
            
            performSelector(#selector(viewWillAppear), withObject: view, afterDelay: 0.5)
            
            
        }
        
        
        
    }
    
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        print("Quiz done")
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        resultsTableView.estimatedRowHeight = 82
//        resultsTableView.rowHeight = UITableViewAutomaticDimension
        resultsTableView.backgroundColor = LbeigeColor
        resultsTableView.separatorColor = UIColor.blackColor()
        resultsTableView.alpha = 0
        resultsQuestionLabel.alpha = 0
        resultsAnswerLabel.alpha = 0
        resultsWrongsLabel.alpha = 0
        resultsBlackBand.alpha = 0
        

        quizCardArray = folder?.quizCardArray
        for (index, _) in quizCardArray!.enumerate() { arrayOfIndex.append(index) }
        
        
        for card in quizCardArray!
        {
            quizArray.append(card)
        }
        
        
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
            
            print(" Flashcard saved")
            
            // Folder already has cards because we append them as we create them...no need to retrieve them
            
        }
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        self.resultsTableView.reloadData() 
        show()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}

extension QuizFlashcardViewController: UITableViewDataSource
{
    // the result table will have all cards with their questions, answers, and number of wrongs - we then hve to set the number of wrongs to 0 each time the quiz is done

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("resultCell", forIndexPath: indexPath) as! ResultsTableViewCell
        // recylcing cells and downcasting the cell to a ListNotesTableViewCell
        
    
        let row = indexPath.row
        
        // 2
        let card = quizCardArray![row]
        
        cell.resultsQuestion.backgroundColor = LbeigeColor
        cell.resultsAnswer.backgroundColor = LbeigeColor
        cell.resultsQuestion.text = card.question
        cell.resultsAnswer.text = card.answer
        cell.resultsWrongs.text = String(card.wrong)
        cell.backgroundColor = LbeigeColor

        return  cell  }
    
    
}





