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

    @IBOutlet weak var folderTitleBar: UINavigationItem!
    
    @IBOutlet weak var flashcardCollectionView: UICollectionView!
    
    let reuseIdentifier = "flashcard"
    // pass folder clicked to flashcard V.C
    
    
    //    var cards = ["Question 1", "Question 2", "Question 3"]
    //    var cards: [Flashcard] = []
    
   // var cards: Results<Flashcard>! // Dont need..drop all cards in passed folder's array (of cards)
    //var cards = List<Flashcard>() - replaced by array inside the folder we just passed
    var folder: Folder? 
    
//    @IBAction func addFlashcardAction(sender: AnyObject) {
//        
//        let card = Flashcard()
//        card.question = ""
//        card.answer = ""
//        print("Flashcard created")
//        
//        let realm = try! Realm()
//        try! realm.write(){
//            folder!.cardArray.append(card)}
//       // RealmHelper.addCard(card)
//        flashcardCollectionView.reloadData()
//    }
    
    
    @IBAction func shareAction(sender: AnyObject) {
        
        if folder?.cardArray.count > 0 {
         
            // come back...might want to use nil coalescing operator
        let activityVC = UIActivityViewController(activityItems: [(folder?.cardArray)!], applicationActivities: nil)
            
            // Excluding activities not needed
//            activityVC.excludedActivityTypes = [UIActivityTypePostToTwitter,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo]
        self.presentViewController(activityVC, animated: true, completion: nil)
     }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // cards = RealmHelper.retrieveFlashcard()
        
        // Store all cards in array of the foler we passed
        // Folder.cardArray = RealmHelper.retrieveFlashcard()
        
        
        //        print("\(cards)")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        // reloading the model before it appears
        
        folderTitleBar.title = (folder!.title)
        flashcardCollectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        // REVIEW!!!!
        
        let identifier = segue.identifier
        if identifier == "existingFlashcard"
        {
         // create a new flashcard and populate it with existing content. Else, create a new flashcard with empty fields.
       
            var indexPaths: [NSIndexPath] = flashcardCollectionView.indexPathsForSelectedItems()!
            let card = folder?.cardArray[indexPaths[0].row]
            
            let displayFlashcardViewController = segue.destinationViewController as! FlashcardViewController
            displayFlashcardViewController.card = card
            print("Existing flashcard opened")
            
        }
        else if identifier == "newFlashcard"{
            let newFlashcardVC = segue.destinationViewController as!NewFlashcardViewController
            newFlashcardVC.folder = folder
            
           print("New flashcard")
        }
    
    }
    
    // Preparing the VC to receive an unwind segue
    @IBAction func unwindToFolderTitleViewController(Segue: UIStoryboardSegue) {}
    


}


extension FolderTitleViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 3
//    }
 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
//     Debugging Step: for (index, card) in cards.enumerate(){ print("card number \(index): \(card.question), \(card.answer)") }
        
        // Used nil coalescing operator to make sure 0 is returned in case there are no folder cause retunr line would just no be executed if folder is 0 since the return should be an int
        return folder?.cardArray.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FlashcardCollectionViewCell
        let card = folder?.cardArray[indexPath.row]
        
        
        //    Debugging steps:
        //    print("CARD \(indexPath.row): \(card)")
        //    print("card number \(index): \(card.question), \(card.answer)")
        
        
        // Card is ow optional because in the previous line it is taking an optional folder so card itself will not exist if there is no folder
        cell.flashcardContent.text = card?.question
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
