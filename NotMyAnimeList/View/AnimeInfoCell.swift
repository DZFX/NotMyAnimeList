//
//  AnimeInfoCell.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/30/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

class AnimeInfoCell: UITableViewCell {

    var romajiTitle: String? {
        set {
            self.romajiTitleLabel.text = newValue
        }
        
        get {
            return self.romajiTitleLabel.text
        }
    }
    
    var japaneseTitle: String? {
        set {
            self.japaneseTitleLabel.text = newValue
        }
        
        get {
            return self.japaneseTitleLabel.text
        }
    }
    
    var mediaType: String? {
        set {
            self.mediaTypeLabek.text = newValue
        }
        
        get {
            return self.mediaTypeLabek.text
        }
    }
    
    var score: String? {
        didSet {
            self.scoreLabel.text = "Score: \(score ?? ""))"
        }
    }
    
    var seriesDescription: String? {
        set {
            self.seriesDescriptionLabel.text = newValue
        }
        
        get {
            return self.seriesDescriptionLabel.text
        }
    }
    
    @IBOutlet weak var romajiTitleLabel: UILabel!
    @IBOutlet weak var japaneseTitleLabel: UILabel!
    @IBOutlet weak var mediaTypeLabek: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var seriesDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
