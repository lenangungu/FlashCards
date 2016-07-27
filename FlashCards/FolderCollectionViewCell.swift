//
//  FolderCollectionViewCell.swift
//  FlashCards
//
//  Created by Lena Ngungu on 7/16/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class FolderCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
 
    @IBOutlet weak var folderImage: UIImageView!
    
    @IBOutlet weak var folderName: UITextField!
    
    // Folder  of data model to be passed to cell
    var folder: Folder?
    var cellIndex = 0
    
    
    // Function notifying us that user had tapped return key
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        print(textField.text)
        
        let newFolder = Folder()
        newFolder.title = textField.text!
        
        // Make cursor dissapear when enter is pressed
        textField.endEditing(true)
        
      // folder is an optional thefore we need to unwrap it first
       RealmHelper.updateFolder(folder!, newFolder: newFolder)
        
        return true
    }
    
 
}
