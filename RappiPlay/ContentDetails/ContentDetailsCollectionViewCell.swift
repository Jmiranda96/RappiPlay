//
//  ContentDetailsCollectionViewCell.swift
//  RappiPlay
//
//  Created by Jorge Miranda on 15/10/21.
//

import UIKit

class ContentDetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImage: UrlImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var url: String? {
        didSet {
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        self.mainImage.image = UIImage(named: "Image-Not-Available")
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
        if let _ = url {
            loader.stopAnimating()
            self.mainImage.loadImageFromUrl("https://image.tmdb.org/t/p/w500/\(url!)")
        }
    }
}
