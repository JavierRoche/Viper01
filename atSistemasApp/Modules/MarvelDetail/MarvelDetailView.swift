//
//  MarvelDetailView.swift
//  atSistemasApp
//
//  Created by APPLE on 14/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import UIKit

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


// MARK: UITableView DataSource

extension MarvelDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            /// Char data cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MarvelDetailDataCell.self), for: indexPath) as? MarvelDetailDataCell else { fatalError() }
            cell.configureCell(char: char)
            return cell
         
        case 1:
            /// Comics cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MarvelDetailComicsCell.self), for: indexPath) as? MarvelDetailComicsCell else { fatalError() }
            cell.configureCell(comicList: comicList)
            return cell
        
        default: break
        }
        
        return UITableViewCell()
    }
}

