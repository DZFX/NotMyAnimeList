//
//  SectionedCollectionViewCell.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

protocol SectionedCollectionViewCellDataSource: class {
    func sectionedCollectionCell(_ sectionedCollectionCell: SectionedCollectionViewCell, numberOfItemsInSection section: Int) -> Int
    func sectionedCollectionCell(_ sectionedCollectionCell: SectionedCollectionViewCell, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell
}

protocol SectionedCollectionViewCellDelegate: class {
    func sectionedCollectionCell(_ sectionedCollectionCell: SectionedCollectionViewCell, didSelectItemAtIndexPath indexPath: IndexPath)
    func sectionedCollectionCell(_ sectionedCollectionCell: SectionedCollectionViewCell, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
}

class SectionedCollectionViewCell: UICollectionViewCell {
    var genre: String? {
        set {
            self.genreLabel.text = newValue
        }
        
        get {
            return self.genreLabel.text
        }
    }
    
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var dataSource: SectionedCollectionViewCellDataSource?
    weak var delegate: SectionedCollectionViewCellDelegate?
    
    var section = 0
}

extension SectionedCollectionViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource?.sectionedCollectionCell(self, numberOfItemsInSection: self.section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let correctedIndexPath = IndexPath(item: indexPath.item, section: self.section)
        return self.dataSource?.sectionedCollectionCell(self, cellForItemAtIndexPath: correctedIndexPath) ?? UICollectionViewCell()
    }
}

extension SectionedCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let correctedIndexPath = IndexPath(item: indexPath.item, section: self.section)
        self.delegate?.sectionedCollectionCell(self, didSelectItemAtIndexPath: correctedIndexPath)
    }
}

extension SectionedCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let correctedIndexPath = IndexPath(item: indexPath.item, section: self.section)
        return self.delegate?.sectionedCollectionCell(self, layout: collectionViewLayout, sizeForItemAtIndexPath: correctedIndexPath) ?? CGSize.zero
    }
}


