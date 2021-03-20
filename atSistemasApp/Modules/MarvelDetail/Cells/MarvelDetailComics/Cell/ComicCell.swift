//
//  ComicCell.swift
//  atSistemasApp
//
//  Created by APPLE on 14/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit
import Kingfisher

/// Celda que representa un comic de la lista
class ComicCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
        
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 8.0
        imageView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    
    // MARK: Public Functions
    
    func configureCell(comic: Comic) {
        /// Tune image url and retrieve with Kingfisher
        let http = "\(comic.thumbnail?.path ?? String())/\(Constants.urlImageSize).\(comic.thumbnail?.imageExtension ?? String())"
        let imageURL = Constants.https + http.dropFirst(4)
        guard let url = URL.init(string: imageURL) else { return }
        imageView.kf.setImage(with: url) { [weak self] result in
            switch result {
            case .success(let value):
                self?.imageView.image = value.image
                
            case .failure:
                self?.imageView.image = UIImage(systemName: Constants.iconImageWarning)
            }
        }
    }
}
