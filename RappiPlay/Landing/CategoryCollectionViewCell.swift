//
//  CategoryCollectionViewCell.swift
//  RappiPlay
//
//  Created by Jorge Miranda on 12/10/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImage: UrlImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var catInfo: MovieService.MovieResult? {
        didSet {
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        self.mainImage.layer.cornerRadius = 10
        self.mainImage.clipsToBounds = true
        setup()
    }
    
    override func prepareForReuse() {
        self.loader.startAnimating()
        self.mainImage.image = nil
    }
    
    func setup() {
        self.loader.hidesWhenStopped = true
        self.loader.startAnimating()
    }
    
    func updateUI() {
        if let info = catInfo {
            guard let imgUrl = info.poster_path else {
                self.loader.startAnimating()
                return
            }
            self.loader.stopAnimating()
            self.mainImage.loadImageFromUrl("https://image.tmdb.org/t/p/w500/\(imgUrl)")
        }
    }
    
}
