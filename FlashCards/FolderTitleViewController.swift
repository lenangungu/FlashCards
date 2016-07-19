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
   
    @IBOutlet weak var flashcardCollectionView: UICollectionView!
    

    @IBOutlet weak var numOfCompletedCards: UILabel!
 
    
//    var cards = ["Question 1", "Question 2", "Question 3"]
//    var cards: [Flashcard] = []
    
    var cards: Results<Flashcard>!{
        didSet{
            flashcardCollectionView.reloadData()
        }
    }
    
    let reuseIdentifier = "flashcard"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        cards = RealmHelper.retrieveFlashcard()

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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        
        // REVIEW!!!!
        
        let identifier = segue.identifier
        if identifier == "existingFlashcard"
        {
         // create a new flashcard and populate it with existing content. Else, create a new flashcard with empty fields.
       
            var indexPath: [NSIndexPath]
            indexPath = flashcardCollectionView.indexPathsForSelectedItems()!
            let card = cards[indexPath[0].row]
            
            let displayFlashcardViewController = segue.destinationViewController as! FlashcardViewController
            displayFlashcardViewController.card = card
            
        }
        else if identifier == "newFlashcard"{
           print("New flashcard created")
        }
    
    }
    
    // Preparing the VC to receive an unwind segue
    @IBAction func unwindToFolderTitleViewController(Segue: UIStoryboardSegue) {}

}


extension FolderTitleViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cards.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
              let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FlashcardCollectionViewCell
        let row = indexPath.row

        let card = cards[row]
        
        cell.flashcardContent.text = card.question
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print (" Flashcard \(indexPath.item) was selected")
    }
}
