//
//  MarvelListCell.swift
//  atSistemasApp
//
//  Created by APPLE on 13/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit
import Kingfisher

protocol MarvelListCellDelegate: class {
    func favouriteButtonTapped(char: Character)
}

class MarvelListCell: UITableViewCell {
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var charLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    weak var delegate: MarvelListCellDelegate?
    var char: Character!
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        charImageView.layer.cornerRadius = 8.0
        charImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        charImageView.image = nil
        charLabel.text = nil
        favouriteButton.setImage(UIImage.init(systemName: "heart"), for: .normal)
    }
    
    
    // MARK: User Interactions
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        sender.isSelected = sender.isSelected ? false : true
        delegate?.favouriteButtonTapped(char: self.char)
    }
    
    
    // MARK: Public Functions
    
    func configureCell(char: Character) {
        self.char = char
        
        setImageCell()
        charLabel.text = char.name
        favouriteButton.isSelected = char.favourite ?? false
    }
    
    
    // MARK: Private Functions
    
    fileprivate func setImageCell() {
        /// Tune image url and retrieve with Kingfisher
        let http = "\(char.thumbnail.path ?? String())/\(Constants.urlImageSize).\(char.thumbnail.imageExtension ?? String())"
        let urlFixed = Constants.https + http.dropFirst(4)
        guard let url = URL.init(string: urlFixed) else { return }
        charImageView.kf.setImage(with: url) { [weak self] result in
            switch result {
            case .success(let value):
                self?.charImageView.image = value.image
                
            case .failure:
                self?.charImageView.image = UIImage(systemName: Constants.iconImageWarning)
            }
        }
    }
}
