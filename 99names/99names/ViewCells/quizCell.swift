//
//  quizCell.swift
//  99names
//
//  Created by Helal Chowdhury on 4/27/20.
//  Copyright © 2020 Helal. All rights reserved.
//
var count = 0

import UIKit
import Gemini
import Firebase

class quizCell: GeminiCell {
    
    
    var cards = ["beige", "purple", "teel","orange", "green","pink"]
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var arabicLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var cardView: UIImageView!
    @IBOutlet weak var originalLabel: UILabel!
    
    
    
    func setData(arabic: String, name: String, meaning: String) {
        self.arabicLabel.text = arabic
        self.nameLabel.text = name
        self.meaningLabel.text = meaning
        self.meaningLabel.isHidden = true
        self.cardView.image = UIImage(named: self.cards[count % cards.count])
        count = count + 1
        self.originalLabel.text = "Tap to reveal answer"
    }
    
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        if self.meaningLabel.isHidden == false{
            self.meaningLabel.isHidden = true
            self.originalLabel.isHidden = false
            Analytics.logEvent("meaning_label_hide", parameters: nil)        }
        else{
            self.meaningLabel.isHidden = false
            self.originalLabel.isHidden = true
            Analytics.logEvent("meaning_label_show", parameters: nil) 
        }
    }
    
    
}

