//
//  SearchVC+UITableview+Extension.swift
//  Movies
//
//  Created by Apple on 01/01/24.
//

import Foundation
import UIKit

extension SearchVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchOn ? arrFiltered?.count ?? 0 : arrOriginal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CVCellnames.PopularMoviesTVC, for: indexPath) as? PopularMoviesTVC else {
            
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        if isSearchOn {
            guard let movie = arrFiltered?[indexPath.item] else { return cell }
            cell.setupData(movie: movie)
        } else {
            let movie = arrOriginal[indexPath.item]
            cell.setupData(movie: movie)
        }
        return cell
    }
}

extension SearchVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }    
}
