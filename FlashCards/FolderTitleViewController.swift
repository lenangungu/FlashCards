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
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var playButton: UIBarButtonItem!
    
    let reuseIdentifier = "flashcard"
    // pass folder clicked to flashcard V.C
    
    
    //    var cards = ["Question 1", "Question 2", "Question 3"]
    //    var cards: [Flashcard] = []
    
   // var cards: Results<Flashcard>! // Dont need..drop all cards in passed folder's array (of cards)
    //var cards = List<Flashcard>() - replaced by array inside the folder we just passed
    var folder: Folder?
    var selectedFolders = [Folder]() 
    
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
//    
    
    @IBAction func shareAction(sender: AnyObject) {
        
        if folder?.cardArray.count > 0 {
         shareButton.enabled = true
            // come back...might want to use nil coalescing operator
        let activityVC = UIActivityViewController(activityItems: [(folder?.cardArray)!], applicationActivities: nil)
            
            // Excluding activities not needed
//            activityVC.excludedActivityTypes = [UIActivityTypePostToTwitter,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo]
        self.presentViewController(activityVC, animated: true, completion: nil)
     }
//        else {shareButton.enabled = false} 
    }
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem()
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
        
        if folder?.cardArray.count < 1
        {
            playButton.enabled = false
            shareButton.enabled = false
        }
        else {
            playButton.enabled = true
            shareButton.enabled = true 
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        // REVIEW!!!!
        
        let identifier = segue.identifier
        if identifier == "quizFlashcard"
        {
         // create a new flashcard and populate it with existing content. Else, create a new flashcard with empty fields.
   
            
             let quizFlashcardViewController = segue.destinationViewController as! QuizFlashcardViewController
            
              quizFlashcardViewController.folder = folder
             let count = folder?.cardArray.count
             let rand = Int(arc4random_uniform((UInt32(count! - 1))))
             quizFlashcardViewController.card = folder!.cardArray[rand]
//              quizFlashcardViewController.card = folder!.cardArray[0]
            
            
           
//            displayFlashcardViewController.card = card
            
                print("Quiz opened")}
           
            
        
        else if identifier == "newFlashcard"{
            
            let newFlashcardViewController = segue.destinationViewController as! FlashcardViewController
            newFlashcardViewController.folder = folder 
           print("New flashcard")
        }
        
        else if identifier == "existingFlashcard"
        {
            // create a new flashcard and populate it with existing content. Else, create a new flashcard with empty fields.
            
                       var indexPaths: [NSIndexPath] = flashcardCollectionView.indexPathsForSelectedItems()!
                       let card = folder?.cardArray[indexPaths[0].row]
            
            let displayFlashcardViewController = segue.destinationViewController as! SingleFlashcardViewController
            
            displayFlashcardViewController.card = card 
            
            //            displayFlashcardViewController.card = card
        }
    
    }
    
    // Preparing the VC to receive an unwind segue
    @IBAction func unwindToFolderTitleViewController(Segue: UIStoryboardSegue) {}
    


}


extension FolderTitleViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
 
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

extension FolderTitleViewController: UICollectionViewDelegateFlowLayout {
    // Asks the delegate for the size of the specified item’s cell. cvWidth is the global var I created in the collectionView IBOutlet
    // RETURN: The width and height of the specified item. Both values must be greater than 0.
  
    // Asks the delegate for the margins to apply to content in the specified section.
    // RETURN: The margins to apply to items in the section.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 5, bottom: 0, right: 5)
    }
    
    // Asks the delegate for the spacing between successive rows or columns of a section.
    // RETURN: The minimum space (measured in points) to apply between successive lines in a section.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return  10  }
    
    // Asks the delegate for the spacing between successive items in the rows or columns of a section.
    // RETURN: The minimum space (measured in points) to apply between successive items in the lines of a section.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return -15
    }
    
    // Asks the delegate for the size of the header view in the specified section.
    // RETURN: The size of the header. If you return a value of size (0, 0), no header is added.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    // Asks the delegate for the size of the footer view in the specified section.
    // RETURN: The size of the footer. If you return a value of size (0, 0), no footer is added.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
}
}
