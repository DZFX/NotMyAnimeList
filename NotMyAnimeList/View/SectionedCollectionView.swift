//
//  SectionedCollectionView.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

protocol SectionedCollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSections(_ collectionView: SectionedCollectionView) -> Int
    func sectionedCollectionView(_ collectionView: SectionedCollectionView, numberOfItemsInSection section: Int) -> Int
    func sectionedCollectionView(_ collectionView: SectionedCollectionView, rowCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func sectionedCollectionView(_ collectionView: SectionedCollectionView, titleForSection section: Int) -> String?
}

protocol SectionedCollectionViewDelegate: UICollectionViewDelegate {
    func sectionedCollectionView(_ collectionView: SectionedCollectionView, didSelectItemAt indexPath: IndexPath)
}

private let SectionedCollectionCellIdentifier = "SectionedCollectionCell"

class SectionedCollectionView: UICollectionView {
    
    var sectionedDataSource: SectionedCollectionViewDataSource?
    var sectionedDelegate: SectionedCollectionViewDelegate?
    var currentSection = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
    }
    
    func isVisible(indexPath: IndexPath) -> Bool {
        let indexPathInVerticalCollectionView = IndexPath(item: 0, section: indexPath.section)
        if let cellWithHorizontalCollectionView = self.cellForItem(at: indexPathInVerticalCollectionView) as? SectionedCollectionViewCell {
            let indexPathInHorizontalCollectionView = IndexPath(item: indexPath.item, section: 0)
            return cellWithHorizontalCollectionView.collectionView.indexPathsForVisibleItems.contains(indexPathInHorizontalCollectionView)
        }
        
        return false
    }
    
    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        if identifier != SectionedCollectionCellIdentifier {
            let correctedIndexPathForEmbeddedCollectionView = IndexPath(item: indexPath.item, section: 0)
            if let collectionViewFromActualRow = self.cellForItem(at: IndexPath(item: 0, section: indexPath.section)) as? SectionedCollectionViewCell {
                
                return collectionViewFromActualRow.collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: correctedIndexPathForEmbeddedCollectionView)
            }
            if let cell = self.visibleCells.first as? SectionedCollectionViewCell{
                return cell.collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: IndexPath(item: 0, section: 0))
            }
        }
        
        return super.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
}

extension SectionedCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionedDataSource?.numberOfSections(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionedCollectionCell", for: indexPath) as? SectionedCollectionViewCell {
            cell.dataSource = self
            cell.delegate = self
            cell.section = indexPath.section
            cell.genre = self.sectionedDataSource?.sectionedCollectionView(self, titleForSection: cell.section)
            cell.collectionView.reloadData()
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension SectionedCollectionView: UICollectionViewDelegate {
    
}

extension SectionedCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 145)
    }
}

extension SectionedCollectionView: SectionedCollectionViewCellDataSource {
    func sectionedCollectionCell(_ sectionedCollectionCell: SectionedCollectionViewCell, numberOfItemsInSection section: Int) -> Int {
        return self.sectionedDataSource?.sectionedCollectionView(self, numberOfItemsInSection: section) ?? 00
    }
    
    func sectionedCollectionCell(_ sectionedCollectionCell: SectionedCollectionViewCell, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        return self.sectionedDataSource?.sectionedCollectionView(self, rowCollectionView: sectionedCollectionCell.collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
}

extension SectionedCollectionView: SectionedCollectionViewCellDelegate {
    func sectionedCollectionCell(_ sectionedCollectionCell: SectionedCollectionViewCell, didSelectItemAtIndexPath indexPath: IndexPath) {
        self.sectionedDelegate?.sectionedCollectionView(self, didSelectItemAt: indexPath)
    }
    
    func sectionedCollectionCell(_ sectionedCollectionCell: SectionedCollectionViewCell, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: sectionedCollectionCell.collectionView.bounds.size.height)
    }
}
