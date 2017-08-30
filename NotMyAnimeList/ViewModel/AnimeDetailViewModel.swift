//
//  AnimeDetailViewModel.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/30/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

fileprivate let animeDetailCellIdentifier = "AnimeDetailCellIdentifier"

protocol AnimeDetailViewModelDelegate: class {
    func animeDetailViewModelDidFinishDownloadingDetals(animeDetailViewModel: AnimeDetailViewModel)
}

class AnimeDetailViewModel: NSObject {

    var anime: Anime?
    weak var delegate: AnimeDetailViewModelDelegate?
    
    func downloadData() {
        self.anime?.downloadFullDetail(completion: { (anime, error) in
            if let _anime = anime {
                self.anime = _anime
                self.delegate?.animeDetailViewModelDidFinishDownloadingDetals(animeDetailViewModel: self)
            }
        })
    }
    
    func imageViewWithAnimeBanner() -> UIImageView {
        let imageView = UIImageView()
        if let url = URL(string: self.anime?.bannerURL ?? "") {
            imageView.af_setImage(withURL: url, placeholderImage: UIImage(), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.crossDissolve(0.24), runImageTransitionIfCached: false) { (response: DataResponse<UIImage>) in
                if let _image = response.value {
                    self.anime?.banner = _image
                } else {
                    print(response.result.error ?? "")
                }
            }
        }
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = self.anime?.image
        return imageView
    }
    
    func tableView(_ tableView: UITableView, infoCellForRowAt indexPath: IndexPath) -> AnimeInfoCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: animeDetailCellIdentifier) as? AnimeInfoCell {
                cell.romajiTitle = self.anime?.titleRomaji
                cell.japaneseTitle = self.anime?.titleJapanese
                cell.mediaType = self.anime?.mediaType
                cell.score = self.anime?.averageScore
                cell.seriesDescription = self.anime?.seriesDescription
                return cell
            }
        }
        return AnimeInfoCell()
    }
    
    func tableView(_ tableView: UITableView, infoHeighForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let attributedString = NSAttributedString(string: self.anime?.seriesDescription ?? "", attributes: [NSFontAttributeName : UIFont(name: "AvenirNext-Regular", size: 12.0) ?? UIFont()])
            let constrainedRect = CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude)
            let boundingBox = attributedString.boundingRect(with: constrainedRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
            return boundingBox.size.height + 60
        }
        return 0.0
    }
}
