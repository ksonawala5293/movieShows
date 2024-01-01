//
//  MovieDetailsVC.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import UIKit

struct DetailsCellnames {
    static let BannerTVC = "BannerTVC"
    static let DetailsTVC = "DetailsTVC"
}

class MovieDetailsVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tblDetails: UITableView!
    
    //MARK: - Variables
    var detailShowingFor: Int?
    let vmMovieDetails = MovieDetailsVM()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialUISetup()
        configuration()
    }
}

//MARK: - Custom methods
extension MovieDetailsVC {
    private func initialUISetup() {
        tblDetails.register(UINib(nibName: DetailsCellnames.BannerTVC, bundle: nil), forCellReuseIdentifier: DetailsCellnames.BannerTVC)
        tblDetails.register(UINib(nibName: DetailsCellnames.DetailsTVC, bundle: nil), forCellReuseIdentifier: DetailsCellnames.DetailsTVC)
        
        tblDetails.estimatedRowHeight = 200
        tblDetails.rowHeight = UITableView.automaticDimension
    }
    
    private func loadData() {
        tblDetails.dataSource = self
        
        tblDetails.reloadData()
    }
}

//MARK: - Viewmodel binding
extension MovieDetailsVC {
    func configuration() {
        initModel()
        eventHandlers()
    }
    
    func initModel() {
        if let id = self.detailShowingFor {
            self.vmMovieDetails.callFetchAPI(for: id)
        }
    }
    
    func eventHandlers() {
        vmMovieDetails.eventListner = {[weak self] event in
            guard let self else {return}
            
            switch event {
            case .startLoading:
                indicator.isHidden = false
                break
            case .stopLoading:
                indicator.isHidden = true
                break
            case .dataReceived:
                DispatchQueue.main.async {
                    self.indicator.isHidden = true
                    self.loadData()
                }
            case .error(_):
                indicator.isHidden = true
                break
            }
        }
    }
}
