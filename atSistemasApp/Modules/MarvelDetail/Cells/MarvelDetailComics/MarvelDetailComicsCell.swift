//
//  MarvelDetailComicsCell.swift
//  atSistemasApp
//
//  Created by APPLE on 14/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

class MarvelDetailComicsCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var comicList = [Comic]()
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /// Register cell of table and delegate / datasource
        let nib = UINib.init(nibName: String(describing: ComicCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: ComicCell.self))
        collectionView.dataSource = self
    }
    
    
    // MARK: Public Functions
    
    func configureCell(comicList: [Comic]) {
        self.comicList = comicList
        collectionView.reloadData()
    }
}


// MARK: UICollectionView DataSource

extension MarvelDetailComicsCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String(describing: ComicCell.self), for: indexPath) as? ComicCell else {
            fatalError()
        }
        
        cell.configureCell(comic: comicList[indexPath.row])
        return cell
    }
}
