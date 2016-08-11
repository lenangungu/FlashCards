//
//  FolderTitleViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/16/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import RealmSwift
import Mixpanel

class FolderTitleViewController: UIViewController {

    @IBOutlet weak var folderTitleBar: UINavigationItem!
    
    @IBOutlet weak var flashcardCollectionView: UICollectionView!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
   
 
    
    @IBOutlet weak var playButton: UIButton!
    
    
    let reuseIdentifier = "flashcard"

    var folder: Folder?
    var selectedCardIndex: [Int]?
    var del: UIBarButtonItem?
    
    @IBAction func shareAction(sender: AnyObject) {
        
        if folder?.cardArray.count > 0 {
         shareButton.enabled = true
            
            // come back...might want to use nil coalescing operator
//        let activityVC = UIActivityViewController(activityItems: [(folder?.cardArray)!], applicationActivities: nil)
//            
//            // Excluding activities not needed
////            activityVC.excludedActivityTypes = [UIActivityTypePostToTwitter,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo]
//        self.presentViewController(activityVC, animated: true, completion: nil)
//     }
////        else {shareButton.enabled = false} 
}
    }
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }

    
    @IBAction func deleteLongPressAction(sender: UILongPressGestureRecognizer) {
        
        flashcardCollectionView.allowsMultipleSelection = false
        
        let cellIndex = (sender.view as! FlashcardCollectionViewCell).cellIndex
        
        let questionController = UIAlertController(title: "Delete card?", message: nil, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        {(action) in
//            
//            (sender.view as! FlashcardCollectionViewCell).backgroundColor = nil}
        
        
        
        
        let deleteAction = UIAlertAction(title: "Delete", style: .Default){(action) in
            
            
            // delete the folder prop erty of the cell that underwent the recognizer
            // Th sender's view is a cell
            
            RealmHelper.deleteCard((self.folder?.cardArray[cellIndex])!)
            
            
            
            self.flashcardCollectionView.reloadData()
            
            print(self.folder?.cardArray)
        }
        
        
        questionController.addAction(deleteAction)
        questionController.addAction(cancelAction)
        
        
        
        self.presentViewController(questionController, animated: true, completion: nil)
        print(folder?.cardArray)
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Folder deleted")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // reloading the model before it appears
        
        folderTitleBar.title = (folder!.title)
        flashcardCollectionView.reloadData()
        
        if folder?.cardArray.count < 1
        {
            playButton.enabled = false
           // shareButton.enabled = false
        }
        else {
            playButton.enabled = true
          //  shareButton.enabled = true
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
      //       let count = folder?.cardArray.count
            // let rand = Int(arc4random_uniform((UInt32(count! - 1))))
        //     quizFlashcardViewController.card = folder!.cardArray[rand]
            
            
            quizFlashcardViewController.cardArray = folder!.cardArray
            quizFlashcardViewController.quizCardArray = folder!.quizCardArray
            quizFlashcardViewController.card = folder!.quizCardArray[0]
            
                print("Quiz opened")
            let mixpanel: Mixpanel = Mixpanel.sharedInstance()
            mixpanel.track("Quiz opened")
        }
           
            
        
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
        
        
        // Card is now optional because in the previous line it is taking an optional folder so card itself will not exist if there is no folder
        cell.flashcardContent.text = card?.question
        
        
        cell.cellIndex = indexPath.row
        let gestureRecognizer = UILongPressGestureRecognizer()
        
        // Add target to
        // The target is the View controller that will handle the gesture
        // The selector is the name of the function
        // Object.property or . method
        // self is the instance of the class where the object was made in
        // Action, which is the selector, has to be in quotes
        
        gestureRecognizer.addTarget(self , action: #selector(FolderTitleViewController.deleteLongPressAction(_:)))
        // Adding recognizer to cell
        cell.addGestureRecognizer(gestureRecognizer)

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
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //print(collectionView.frame.width)
        //print(collectionView.frame.height)
        return CGSize(width: (flashcardCollectionView.frame.width / 3.3), height: (flashcardCollectionView.frame.width/5.0))
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 5, bottom: 25, right: 5)
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
