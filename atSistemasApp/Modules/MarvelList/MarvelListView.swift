//
//  MarvelListView.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import UIKit

class MarvelListView: BaseViewController, MarvelListViewContract {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
	var presenter: MarvelListPresenterContract!
    
    /// Characters to show
    var charList: [Character] = []
    lazy var refreshControl: UIRefreshControl = {
        let refresh: UIRefreshControl = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: Constants.refreshMessage)
        refresh.addTarget(self, action: #selector(refreshTableViewData), for: .valueChanged)
        return refresh
    }()

    
	// MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.center = self.view.center
        view.addSubview(self.activityIndicator)
        activityIndicator.startAnimating()
        presenter.viewWillAppear()
    }

    
    // MARK: Public Functions
    
    func charListDidChange(charList: [Character]) {
        self.charList = charList
        
        updateWithFavourites()
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    
    // MARK: Private Functions
    
    @objc func refreshTableViewData() {
        presenter.viewWillAppear()
    }
    
    fileprivate func configureUI() {
        /// Register cell of table and delegate / datasource
        let nib = UINib.init(nibName: String(describing: MarvelListCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: MarvelListCell.self))
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    fileprivate func updateWithFavourites() {
        self.charList = charList.map({ character in
            var mutabledChar = character
            mutabledChar.favourite = presenter.isFavouriteChar(id: character.id ?? 0)
            return mutabledChar
        })
    }
}


// MARK: UITableView Delegate

extension MarvelListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.charCellTapped(char: charList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}


// MARK: UITableView DataSource

extension MarvelListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MarvelListCell.self), for: indexPath) as? MarvelListCell else {
            fatalError()
        }
        
        cell.configureCell(char: charList[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}


//MARK: MarvelListCell Delegate

extension MarvelListView: MarvelListCellDelegate {
    func favouriteButtonTapped(char: Character) {
        guard let id = char.id else { return }
        
        /// Update DB
        self.presenter.isFavouriteChar(id: id) ?
            self.presenter.deleteFavouriteChar(id: id) : self.presenter.saveFavouriteChar(id: id)
        
        /// Update model
        updateWithFavourites()
    }
}
