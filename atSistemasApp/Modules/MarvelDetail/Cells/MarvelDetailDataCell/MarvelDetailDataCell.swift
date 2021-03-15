//
//  MarvelDetailDataCell.swift
//  atSistemasApp
//
//  Created by APPLE on 14/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

class MarvelDetailDataCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        descriptionLabel.text = nil
    }
    
    
    // MARK: Public Functions
    
    func configureCell(char: Character) {
        nameLabel.text = char.name
        descriptionLabel.text = char.description
    }
}
