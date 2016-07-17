//
//  ViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/12/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit


class FoldersViewController: UIViewController {
    
    @IBOutlet weak var newFolderButton: UIBarButtonItem!
    @IBOutlet weak var foldersCollectionView: UICollectionView!

    var folders = ["History","French","Math"]
    let resuseIdentifier = "folder"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        cell.folderName.text = folders[indexPath.item]
        
        
        return cell
    }
// MARK: Delegate 
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print ("Folder \(indexPath.item) was selected")
    }
    
}
