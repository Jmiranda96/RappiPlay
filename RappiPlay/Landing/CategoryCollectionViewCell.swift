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
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var catInfo: Any! {
        didSet {
            self.updateUI()
        }
    }
    
    var cellType: MovieService.MediaType!
    
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
        self.mainLabel.isHidden = true
        self.loader.hidesWhenStopped = true
        self.loader.startAnimating()
    }
    
    func updateUI() {
        
        if let info = (catInfo as? MovieServiceSchemas.MovieResult){
            guard let imgUrl = info.posterPath else {
                self.loader.startAnimating()
                return
            }
            self.loader.stopAnimating()
            self.mainImage.loadImageFromUrl("https://image.tmdb.org/t/p/w500/\(imgUrl)")
            self.mainLabel.text = info.title
        } else if let info = (catInfo as? MovieServiceSchemas.TvResult){
            guard let imgUrl = info.posterPath else {
                self.loader.startAnimating()
                return
            }
            self.loader.stopAnimating()
            self.mainImage.loadImageFromUrl("https://image.tmdb.org/t/p/w500/\(imgUrl)")
            self.mainLabel.text = info.name
        }
        
        mainLabel.isHidden = !self.mainImage.usingPlaceholder
    }
    
}
