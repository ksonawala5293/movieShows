//
//  Dashboard+UITableview+Extension.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import Foundation
import UIKit

extension DashboardVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vmDashboard.popularBaseModel?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CVCellnames.PopularMoviesTVC, for: indexPath) as? PopularMoviesTVC else {
            
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        if let movie = vmDashboard.popularBaseModel?.results?[indexPath.item] {
            cell.setupData(movie: movie)
        }
        return cell
    }
}

extension DashboardVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (vmDashboard.popularBaseModel?.results?.count ?? 1)-1 {
            if vmDashboard.popularBaseModel?.total_pages ?? 0 >= vmDashboard.popularMovieListpageNo {
                
                self.vmDashboard.callFetchAPIForPopularMovies(for: movieType.popular, page: vmDashboard.popularMovieListpageNo + 1)
            }
        }
        cell.contentView.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = vmDashboard.popularBaseModel?.results?[indexPath.row] else {return}
        guard let id = movie.id else {return}
        navigateToDetailsVC(for: id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
