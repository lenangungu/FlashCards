//
//  NewFlashcardViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class NewFlashcardViewController: UIViewController {

    @IBOutlet weak var answerTextView: UITextView!
  
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet var saveButton: UIView!
    
     var folder: Folder?
     var card: Flashcard?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        if identifier == "saveNewCard"
        {
            // REVIEW !!!
            
            //if let card = card{
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
        
        func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            
                questionTextView.text = " "
                answerTextView.text = " "
            
            }
            
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
