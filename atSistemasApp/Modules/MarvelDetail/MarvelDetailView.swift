//
//  MarvelDetailView.swift
//  atSistemasApp
//
//  Created by APPLE on 14/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import UIKit

enum Sections: Int {
    case data = 0
    case comics
    
    var name: String {
        switch self {
        case .data:
            return "Personal data"
        case .comics:
            return "Comics"
        }
    }
}

class MarvelDetailView: BaseViewController, MarvelDetailViewContract {
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
	var presenter: MarvelDetailPresenterContract!

    /// Char and comics to show
    var char: Character!
    var comicList: [Comic] = []
    
	// MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        self.char = presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setCharImage()
        presenter.viewWillAppear()
    }
    
    
    // MARK: Public Functions
    
    func comicListDidChange(comicList: [Comic]) {
        self.comicList = comicList
        
        tableView.reloadData()
    }
    
    
    // MARK: Private Functions
    
    fileprivate func configureUI() {
        /// Register cell of table and delegate / datasource
        var nib = UINib.init(nibName: String(describing: MarvelDetailDataCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: MarvelDetailDataCell.self))
        nib = UINib.init(nibName: String(describing: MarvelDetailComicsCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: MarvelDetailComicsCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.rowHeight = UITableView.automaticDimension
        
        /// Image settings
        charImageView.layer.cornerRadius = 8.0
        charImageView.clipsToBounds = true
    }
    
    fileprivate func setCharImage() {
        /// Tune image url and retrieve with Kingfisher
        let http = "\(char.thumbnail.path ?? String())/standard_large.\(char.thumbnail.imageExtension ?? String())"
        let imageURL = Constants.https + http.dropFirst(4)
        guard let url = URL.init(string: imageURL) else { return }
        self.charImageView.kf.setImage(with: url) { [weak self] result in
            switch result {
            case .success(let value):
                self?.charImageView.image = value.image
                
            case .failure(_):
                self?.charImageView.image = UIImage(systemName: Constants.iconImageWarning)
            }
        }
    }
}
