//
//  SearchVC.swift
//  Movies
//
//  Created by Apple on 01/01/24.
//

import UIKit

class SearchVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tblSearch: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    //MARK: - Variables
    var arrOriginal = [PopularMoviesResult]()
    var arrFiltered: [PopularMoviesResult]?
    var isSearchOn = false
    var workItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialUISetup()
    }
}

//MARK: - Custom methods
extension SearchVC {
    private func initialUISetup() {
        tblSearch.register(UINib(nibName: CVCellnames.PopularMoviesTVC, bundle: nil), forCellReuseIdentifier: CVCellnames.PopularMoviesTVC)
        loadData()
    }
    
    private func loadData() {
        tblSearch.delegate = self
        tblSearch.dataSource = self
        tblSearch.estimatedRowHeight = 200
        tblSearch.rowHeight = UITableView.automaticDimension
        
        tblSearch.reloadData()
    }
    
    func performSearch(with text: String) {
        if text.trimmingCharacters(in: .whitespaces).count > 0 {
            isSearchOn = true
        } else {
            isSearchOn = false
        }
        arrFiltered = arrOriginal.filter { ($0.title ?? "").lowercased().contains(text.lowercased()) }
        
        tblSearch.reloadData()
    }
}
