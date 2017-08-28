//
//  AnimeCell.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

class AnimeCell: UICollectionViewCell {
    
    var name: String? {
        set {
            self.nameLabel.text = newValue
        }
        
        get {
            return self.nameLabel.text
        }
    }
    
    @IBOutlet private weak var nameLabel: UILabel!
}
