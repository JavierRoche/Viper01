//
//  MarvelDetailViewSource.swift
//  atSistemasApp
//
//  Created by APPLE on 16/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

// MARK: UITableView Delegate

extension MarvelDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableSection = Sections(rawValue: section) else { return String() }
        return tableSection.name
    }
}


// MARK: UITableView DataSource

extension MarvelDetailView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /// Char data cell / Comics cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MarvelDetailDataCell.self),
                                                           for: indexPath) as? MarvelDetailDataCell else { fatalError() }
            cell.configureCell(char: char)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MarvelDetailComicsCell.self),
                                                           for: indexPath) as? MarvelDetailComicsCell else { fatalError() }
            cell.configureCell(comicList: comicList)
            return cell
        
        default: break
        }
        
        return UITableViewCell()
    }
}
