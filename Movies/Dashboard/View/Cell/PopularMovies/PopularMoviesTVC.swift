//
//  PopularMoviesTVC.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import UIKit

class PopularMoviesTVC: UITableViewCell {

    //MARK: -IBOutlets
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var lblOverview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

//MARK: - Custom methods
extension PopularMoviesTVC {
    func setupData(movie: PopularMoviesResult) {
        lblMovieTitle.text = movie.title
        lblReleaseDate.text = movie.release_date
        lblOverview.text = movie.overview
        
        let url = URL(string: "\(Constant.imageBaseURL)\(movie.backdrop_path ?? "")")
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url!) else {return}
            DispatchQueue.main.async {
                self.backgroundImage.image = UIImage(data: data)
                
                self.contentView.layoutIfNeeded()
            }
        }
    }
}
