//
//  ResultsTableViewCell.swift
//  FlashCards
//
//  Created by Lena Ngungu on 8/20/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var resultsQuestion: UITextView!
    @IBOutlet weak var resultsAnswer: UITextView!
    @IBOutlet weak var resultsWrongs: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
