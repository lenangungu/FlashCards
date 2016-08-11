//
//  ViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/12/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class FoldersViewController: UIViewController, UITextFieldDelegate  {
    
  
    @IBOutlet weak var newFolderButton: UIButton!
  //  @IBOutlet weak var newFolderButton: UIBarButtonItem!
    @IBOutlet weak var foldersCollectionView: UICollectionView!
    //var folders = ["History","French","Math"]
    //var folders: [Folder] = []

    
    var folders: Results<Folder>!
    // optional cause there wont be a folder when app first runs; not folder = Folder() cause we do not want to create a folder, we just want a variable that will accept a folder
    var folder: Folder?
    let resuseIdentifier = "folder"
    
    var selectedFolders = [Folder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        folders = RealmHelper.retrieveFolder()
         print("\(folders)")
      
        // Do any additional setup after loading the view, typically from a nib.
        //Edit button implementation
        
        setEditing(false, animated: false)
        
        // from here!!
        
       // navigationItem.rightBarButtonItem = editButtonItem()
//       foldersCollectionView.allowsMultipleSelection = true
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: FolderCollectionViewCell(), action: #selector(FolderCollectionViewCell.textFieldShouldReturn))
//            
//        view.addGestureRecognizer(tap)
        
       
    }
    

    
    override func viewWillAppear(animated: Bool) {
       
    }
   
   // @IBAction func newFolderAction(sender: AnyObject) {
    

   
    @IBAction func newFolderAction(sender: AnyObject) {
    
    var num = 2
    // Creating a new folder
        
        let newFolder = Folder()
        // if the array has a folder with title New folder, add 1 to the title 
        for folder in folders{
            if newFolder.title == folder.title
            {
                newFolder.title = "New \(num)"
               
                
            }
            else {
                newFolder.title = "New \(folders.count)"
                
              //  newFolder.title = "New"
            }
             num = num + 1
        }
        
        
      //  newFolder.title = "New folder"
        
        // Adding newly created folder to array
        //folders.append(newFolder)
        print("\(newFolder.title)")
       
        
        RealmHelper.addFolder(newFolder)
        foldersCollectionView.reloadData()
        
    
        
        // Reloading the collection view to display the newly created folder
//        foldersCollectionView.reloadData()
        print("Folder created")
     
      
    }
 
    
    @IBAction func deleteLongPressAction(sender: UILongPressGestureRecognizer) {
        
        foldersCollectionView.allowsMultipleSelection = false
        
        let cellIndex = (sender.view as! FolderCollectionViewCell).cellIndex
        
        let questionController = UIAlertController(title: "Delete \(folders[cellIndex].title) folder ?", message: nil, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
//        {(action) in
//            
//            (sender.view as! FolderCollectionViewCell).backgroundColor = nil}
        
        
        //        collectionView(foldersCollectionView, didSelectItemAtIndexPath:(sender.view as! FolderCollectionViewCell).indPath! )
        
        
//        (sender.view as! FolderCollectionViewCell).backgroundColor = UIColor.grayColor()
        
        
        let deleteAction = UIAlertAction(title: "Delete", style: .Default){(action) in
            
            
            
            
            // self.foldersCollectionView.delete(folder)
            //  self.foldersCollectionView.delete
            
            
            // RealmHelper.deleteFolder(sender)
            // delete the folder prop erty of the cell that underwent the recognizer
            // Th sender's view is a cell
            
            RealmHelper.deleteFolder(self.folders[cellIndex])
            
//            (sender.view as! FolderCollectionViewCell).backgroundColor = nil
            
            self.foldersCollectionView.reloadData()
        
            print(self.folders)
        }
//        (sender.view as! FolderCollectionViewCell).highlighted = true
        
        questionController.addAction(deleteAction)
        questionController.addAction(cancelAction)
        
        
        
        self.presentViewController(questionController, animated: true, completion: nil)
        print(folders)

        
    }
  
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let folderTitleVC = segue.destinationViewController as! FolderTitleViewController
        folderTitleVC.navigationItem.title = "Folder title" // Grab the folder title and add the variables of the completed item
        // Pass folder to next V.C
        
        // Ask collection view which cell was selected
        let indexPath = (foldersCollectionView.indexPathsForSelectedItems())![0]
        folder = folders[indexPath.item]
    
       // Passing the selected folder to the next view controller
       folderTitleVC.folder = folder
        
            }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FoldersViewController: UICollectionViewDataSource, UICollectionViewDelegate{
 
// MARK: DataSource
// How many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folders.count
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(resuseIdentifier, forIndexPath: indexPath) as! FolderCollectionViewCell

        let newFolder = folders[indexPath.row]
        //folderNameHolder = newFolder.title
        //newFolder.title = folderNameHolder
        
       // cell.folderName.text = folderNameHolder
        cell.folderName.text = newFolder.title 
      //  cell.folderName.text = folders[indexPath.item]
        
        cell.folder = newFolder
        cell.cellIndex = indexPath.row
        let gestureRecognizer = UILongPressGestureRecognizer()
        
        // Add target to
        // The target is the View controller that will handle the gesture
        // The selector is the name of the function
        // Object.property or . method
        // self is the instance of the class where the object was made in
        // Action, which is the selector, has to be in quotes
        
        gestureRecognizer.addTarget(self , action: #selector(FoldersViewController.deleteLongPressAction(_:)))
        // Adding recognizer to cell
        cell.addGestureRecognizer(gestureRecognizer)
       
        return cell
        
    }
    
    
    
// MARK: Delegate 
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print ("Folder \(indexPath.item + 1) was selected")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(resuseIdentifier, forIndexPath: indexPath) as! FolderCollectionViewCell
        cell.backgroundColor = UIColor.blueColor()
    
//    folder = folders[indexPath.item]
    }
    
//    
//    override func setEditing(editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//        if editing
//        {
//            print("hi")
//            foldersCollectionView.allowsMultipleSelection = true
//            foldersCollectionView.selectItemAtIndexPath(nil, animated: true, scrollPosition: .None)
//            selectedFolders.removeAll(keepCapacity: false)
//           // selectedFolders.append(folder[indexPath])
//            
//        }
//        else {
//            print("bye")
//            foldersCollectionView.allowsMultipleSelection = false
//        }
//    }

    
   
 
}


   

// MARK: Delegate layout

extension FoldersViewController: UICollectionViewDelegateFlowLayout {
    // Asks the delegate for the size of the specified item’s cell. cvWidth is the global var I created in the collectionView IBOutlet
    // RETURN: The width and height of the specified item. Both values must be greater than 0.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //print(collectionView.frame.width)
        //print(collectionView.frame.height)
        return CGSize(width: (foldersCollectionView.frame.width / 3.3), height: (foldersCollectionView.frame.width/3.3))
    }
    
    // Asks the delegate for the margins to apply to content in the specified section.
    // RETURN: The margins to apply to items in the section.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -40, left: 15, bottom: 90, right: 0)
    }
    
    // Asks the delegate for the spacing between successive rows or columns of a section.
    // RETURN: The minimum space (measured in points) to apply between successive lines in a section.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return  5  }
    
    // Asks the delegate for the spacing between successive items in the rows or columns of a section.
    // RETURN: The minimum space (measured in points) to apply between successive items in the lines of a section.
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
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



//    @IBAction func newFolderAction(sender: AnyObject) {
//
//              collectionView(UICollectionView: foldersCollectionView, cellForItemAtIndexPath: indexPath )
//    }


//    @IBAction func newFolderAction(sender: AnyObject) {
//
//        //let createdFolder = folder()
//        let newFolder = folders[]
//        folders = folders.append(newFolder)
//    }




