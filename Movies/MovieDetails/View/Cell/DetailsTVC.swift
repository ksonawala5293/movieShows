//
//  DetailsTVC.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import UIKit

class DetailsTVC: UITableViewCell {

    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblTagLine: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgBanner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setuData(with model: MovieDetailBaseModel?) {
        lblName.text = model?.title
        lblTagLine.text = model?.tagline
        lblDetails.text = model?.overview
        
        
        setuImage(with: "\(Constant.imageBaseURL)\(model?.backdrop_path ?? "")")
        
        self.contentView.layoutIfNeeded()
    }
    
    private func setuImage(with strURL: String) {
        let url = URL(string: strURL)
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url!) else {return}
            DispatchQueue.main.async {
                self.imgBanner.image = UIImage(data: data)
                self.contentView.layoutIfNeeded()
            }
        }
    }
}
