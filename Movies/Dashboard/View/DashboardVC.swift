//
//  DashboardVC.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import UIKit

struct CVCellnames {
    static let PopularMoviesTVC = "PopularMoviesTVC"
    static let NowPlayingCVC = "NowPlayingCVC"
}

struct VCNames {
    static let MovieDetailsVC = "MovieDetailsVC"
    static let SearchVC = "SearchVC"
}

enum MovieType: String {
    case nowPlaying = "now_playing"
    case popular = "popular"
}

class DashboardVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var tblPopularMovies: UITableView!
    @IBOutlet weak var cvNowPlaying: UICollectionView!
    
    //MARK: - Variables
    let vmDashboard = DashboardVM()
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initialUISetup()
        configuration()
    }

    //MARK: -IBAction
    @IBAction func btnSearchTapped(_ sender: Any) {
        navigateToSearchScreen()
    }
}

//MARK: - Custom methods
extension DashboardVC {
    private func initialUISetup() {
        cvNowPlaying.register(UINib(nibName: CVCellnames.NowPlayingCVC, bundle: nil),forCellWithReuseIdentifier: CVCellnames.NowPlayingCVC)
        
        tblPopularMovies.register(UINib(nibName: CVCellnames.PopularMoviesTVC, bundle: nil), forCellReuseIdentifier: CVCellnames.PopularMoviesTVC)
    }
    
    private func loadData() {
        cvNowPlaying.delegate = self
        cvNowPlaying.dataSource = self
        
        tblPopularMovies.delegate = self
        tblPopularMovies.dataSource = self
        tblPopularMovies.estimatedRowHeight = 200
        tblPopularMovies.rowHeight = UITableView.automaticDimension
        
        cvNowPlaying.reloadData()
        tblPopularMovies.reloadData()
    }
    
    func navigateToDetailsVC(for id: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: VCNames.MovieDetailsVC) as? MovieDetailsVC else {return}
        vc.detailShowingFor = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToSearchScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: VCNames.SearchVC) as? SearchVC else {return}
        vc.arrOriginal = vmDashboard.arrPopular
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Viewmodel binding
extension DashboardVC {
    func configuration() {
        initModel()
        eventHandlers()
    }
    
    func initModel() {
        let concurrentQueue = DispatchQueue(label: "concurrent.queue.fetchMovie", attributes: .concurrent)

        concurrentQueue.async {
            self.vmDashboard.callFetchAPIForNowPlayingMovies(for: movieType.nowPlaying, page: 1)
        }
        concurrentQueue.async {
            self.vmDashboard.callFetchAPIForPopularMovies(for: movieType.popular, page: 1)
        }
    }
    
    func eventHandlers() {
        vmDashboard.eventListner = {[weak self] event in
            guard let self else {return}
            
            switch event {
            case .startLoading:
                break
            case .stopLoading:
                break
            case .dataReceived:
                DispatchQueue.main.async {
                    self.loadData()
                }
            case .error(_):
                break
            }
        }
    }
}
