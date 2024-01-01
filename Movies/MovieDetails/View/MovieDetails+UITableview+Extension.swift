//
//  MovieDetails+UITableview+Extension.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import Foundation
import UIKit

extension MovieDetailsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.row {
//        case 0:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCellnames.BannerTVC, for: indexPath) as? BannerTVC else {
//
//                return UITableViewCell()
//            }
//            cell.selectionStyle = .none
//            cell.setuData(with: vmMovieDetails.movieDetailsBaseModel)
//            return cell
//
//        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCellnames.DetailsTVC, for: indexPath) as? DetailsTVC else {
                
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.setuData(with: vmMovieDetails.movieDetailsBaseModel)
            return cell
            
//        default:
//            break
//        }
        
//        return UITableViewCell()
    }
}

extension MovieDetailsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//            return 200
//        case 1:
            return UITableView.automaticDimension
//        default:
//            return 0
//        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layoutIfNeeded()
    }
}
