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
fileprivate let animeCharacterCellIdentifier = "AnimeCharacterCell"

protocol AnimeDetailViewModelDelegate: class {
    func animeDetailViewModelDidFinishDownloadingDetals(animeDetailViewModel: AnimeDetailViewModel)
    func animeDetailViewModelDidDownloadImage(animeDetailViewModel: AnimeDetailViewModel)
}

class AnimeDetailViewModel: NSObject {

    var anime: Anime?
    weak var delegate: AnimeDetailViewModelDelegate?
    var sectionTitles = ["Info", "Characters"]
    
    func downloadData() {
        self.anime?.downloadFullDetail(completion: { (anime, error) in
            if let _anime = anime {
                self.anime = _anime
                self.delegate?.animeDetailViewModelDidFinishDownloadingDetals(animeDetailViewModel: self)
            }
        })
    }
    
    func imageViewWithAnimeBanner() -> UIImageView {
        if let _banner = self.anime?.banner {
            let imageView = UIImageView(image: _banner)
            imageView.contentMode = .scaleAspectFill
            return imageView
        } else if let url = URL(string: self.anime?.bannerURL ?? "") {
            let imageView = UIImageView()
            imageView.af_setImage(withURL: url, placeholderImage: UIImage(), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.crossDissolve(0.24), runImageTransitionIfCached: false) { (response: DataResponse<UIImage>) in
                if let _image = response.value {
                    imageView.bounds = CGRect(origin: CGPoint.zero, size: _image.size)
                    imageView.contentMode = .scaleAspectFill
                    self.anime?.banner = _image
                } else {
                    print(response.result.error ?? "")
                }
                self.delegate?.animeDetailViewModelDidDownloadImage(animeDetailViewModel: self)
            }
            return imageView
        }
        let imageView = UIImageView()
        let url = URL(string: self.anime!.imageURL!)!
        imageView.af_setImage(withURL: url)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    func tableView(_ tableView: UITableView, animeInfoCellForRowAt indexPath: IndexPath) -> AnimeInfoCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: animeDetailCellIdentifier) as? AnimeInfoCell {
            cell.romajiTitle = self.anime?.titleRomaji
            cell.japaneseTitle = self.anime?.titleJapanese
            cell.mediaType = self.anime?.mediaTypeAndRunTime() ?? ""
            cell.score = self.anime?.averageScore
            cell.seriesDescription = self.anime?.seriesDescription?.replacingOccurrences(of: "<br>", with: "").replacingOccurrences(of: "<i>", with: "")
            return cell
        }
        return AnimeInfoCell()
    }
    
    func tableView(_ tableView: UITableView, defaultCellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: animeCharacterCellIdentifier) {
            if let character = self.anime?.characters[indexPath.row] {
                cell.textLabel?.text = character.fullName()
                cell.detailTextLabel?.text = character.role ?? ""
                cell.imageView?.af_setImage(withURL: URL(string: character.imageURL!)!)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, infoCellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return self.tableView(tableView, animeInfoCellForRowAt: indexPath)
        } else if indexPath.section == 1 {
            return self.tableView(tableView, defaultCellForRowAt: indexPath)
        }
        return UITableViewCell()
    }
    
    func titleFor(section: Int) -> String {
        return self.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, infoHeighForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let attributedString = NSAttributedString(string: self.anime?.seriesDescription ?? "", attributes: [NSFontAttributeName : UIFont(name: "AvenirNext-Regular", size: 12.0) ?? UIFont()])
            let constrainedRect = CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude)
            let boundingBox = attributedString.boundingRect(with: constrainedRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
            return boundingBox.size.height + 80
        } else if indexPath.section == 1 {
            return 60.0
        }
        return 0.0
    }
}
