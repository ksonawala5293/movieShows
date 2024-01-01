//
//  Dashboard+UICollectionview+Extension.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import Foundation
import UIKit

extension DashboardVC : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vmDashboard.nowPlayingBaseModel?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCellnames.NowPlayingCVC, for: indexPath) as? NowPlayingCVC else {
            return UICollectionViewCell()
        }
        
        if let movie = vmDashboard.nowPlayingBaseModel?.results?[indexPath.item] {
            cell.setupData(movie: movie)
        }
        return cell
    }
}

extension DashboardVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
