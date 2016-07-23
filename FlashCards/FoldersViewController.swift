//
//  ViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/12/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class FoldersViewController: UIViewController {
    
  
    @IBOutlet weak var newFolderButton: UIBarButtonItem!
    @IBOutlet weak var foldersCollectionView: UICollectionView!
    //var folders = ["History","French","Math"]
    //var folders: [Folder] = []
    
    var folders: Results<Folder>!
    // optional cause there wont be a folder when app first runs; not folder = Folder() cause we do not want to create a folder, we just want a variable that will accept a folder
    var folder: Folder?
    let resuseIdentifier = "folder"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        folders = RealmHelper.retrieveFolder()
         print("\(folders)")
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {

    }
   
    
  
    @IBAction func newFolderAction(sender: AnyObject) {
    // Creating a new folder
        
        let newFolder = Folder()
        newFolder.title = ""
        
        // Adding newly created folder to array
        //folders.append(newFolder)
        print("\(newFolder.title)")
       
        
        RealmHelper.addFolder(newFolder)
        foldersCollectionView.reloadData()
        
    
        
        // Reloading the collection view to display the newly created folder
//        foldersCollectionView.reloadData()
        print("Folder created")
     
      
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
       
        return cell
        
    }
// MARK: Delegate 
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print ("Folder \(indexPath.item + 1) was selected")
//    folder = folders[indexPath.item]
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




