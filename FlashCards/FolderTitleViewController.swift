//
//  FolderTitleViewController.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/16/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class FolderTitleViewController: UIViewController {
    
    var cards = ["Question 1", "Question 2", "Question 3"]
    let reuseIdentifier = "flashcard"
    

    override func viewDidLoad() {
        super.viewDidLoad()

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

}

extension FolderTitleViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cards.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FlashcardCollectionViewCell
        cell.flashcardContent.text = " There are no questions so far "
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print (" Flashcard \(indexPath.item) was selected")
    }
}
