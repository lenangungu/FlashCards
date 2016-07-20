//
//  FolderTitleViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/16/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class FolderTitleViewController: UIViewController {
//    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var flashcardCollectionView: UICollectionView!
    
    let reuseIdentifier = "flashcard"
    
    //    var cards = ["Question 1", "Question 2", "Question 3"]
    //    var cards: [Flashcard] = []
    var cards: Results<Flashcard>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cards = RealmHelper.retrieveFlashcard()
        
        
        //        print("\(cards)")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        // reloading the model before it appears
        flashcardCollectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        // REVIEW!!!!
        
        let identifier = segue.identifier
        if identifier == "existingFlashcard"
        {
         // create a new flashcard and populate it with existing content. Else, create a new flashcard with empty fields.
       
            var indexPaths: [NSIndexPath] = flashcardCollectionView.indexPathsForSelectedItems()!
            let card = cards[indexPaths[0].row]
            
            let displayFlashcardViewController = segue.destinationViewController as! FlashcardViewController
            displayFlashcardViewController.card = card
            print("Existing flashcard opened")
            
        }
        else if identifier == "newFlashcard"{
           print("New flashcard")
        }
    
    }
    
    // Preparing the VC to receive an unwind segue
    @IBAction func unwindToFolderTitleViewController(Segue: UIStoryboardSegue) {}
    


}


extension FolderTitleViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
//     Debugging Step: for (index, card) in cards.enumerate(){ print("card number \(index): \(card.question), \(card.answer)") }
        return cards.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FlashcardCollectionViewCell
        let card = cards[indexPath.row]
        
        
        //    Debugging steps:
        //    print("CARD \(indexPath.row): \(card)")
        //    print("card number \(index): \(card.question), \(card.answer)")

        cell.flashcardContent.text = card.question
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print (" Flashcard \(indexPath.item) was selected")
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
