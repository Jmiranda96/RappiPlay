//
//  ContentDetailsViewController.swift
//  RappiPlay
//
//  Created by Jorge Miranda on 15/10/21.
//

import UIKit

class ContentDetailsViewController: UIViewController, ContentDetailsDelegate {
    
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemRating: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var buyButton: UIStackView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var handlerButton: UIButton!
    
    @IBOutlet weak var GenreLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    var id: Int!
    var contentType: MovieService.MediaType!
    
    var model = ContentDetailsModel()
    
    var homePageUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageCollection.delegate = self
        self.imageCollection.dataSource = self
        self.model.delegate = self
        self.model.getDetails(id: self.id, contentType: self.contentType)
        setupLabel()
        setupHomeButton()
        
    }
    
    func setupLabel() {
        self.handlerButton.clipsToBounds = true
        self.handlerButton.layer.cornerRadius = 3
        itemRating.textColor = UIColor(red: 0.52, green: 0.73, blue: 0.39, alpha: 1)
        itemRating.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func setupHomeButton() {
        self.homeImage.isUserInteractionEnabled = true
        self.homeImage.layer.cornerRadius = 15
        self.homeImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(urlHandler(_:))))
    }
    
    @objc func urlHandler(_ sender: UITapGestureRecognizer? = nil) {
        if let url = URL(string: self.homePageUrl) {
            UIApplication.shared.open(url)
        }
    }

    func setDetails() {
        DispatchQueue.main.async {
            self.setLabelsInfo()
        }
    }
    
    func setDetailImages() {
        DispatchQueue.main.async {
            self.imageCollection.reloadData()
        }
    }
    
    func errorInRequest() {
        
    }
    
    func setLabelsInfo(){
        
        switch contentType {
        case .Movie:
            let movieDetails = model.detailInfo as! MovieServiceSchemas.MovieDetails
            self.itemTitle.text = movieDetails.title
            self.itemRating.text = "\(String(describing: movieDetails.voteAverage!))/10"
            self.itemDescription.text = movieDetails.tagline
            self.homePageUrl = movieDetails.homepage ?? "https://www.themoviedb.org/tv/\(String(describing: movieDetails.id))"
            self.GenreLabel.text = movieDetails.genres?.map({ (genre: MovieServiceSchemas.Genre) -> String in
                return genre.name!
            }).joined(separator: " - ")
            self.overViewLabel.text = movieDetails.overview
            
        case .Tv:
            let tvDetails = model.detailInfo as! MovieServiceSchemas.TvDetails
            self.itemTitle.text = tvDetails.name
            self.itemRating.text = "\(String(describing: tvDetails.voteAverage!))/10"
            self.itemDescription.text = tvDetails.tagline
            self.homePageUrl = tvDetails.homepage ?? "https://www.themoviedb.org/tv/\(String(describing: tvDetails.id))"
            self.GenreLabel.text = tvDetails.genres.map({ (genre: MovieServiceSchemas.Genre) -> String in
                return genre.name!
            }).joined(separator: " - ")
            self.overViewLabel.text = tvDetails.overview
            
        default:
            break
        }
        
    }
    
    @IBAction func pressBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ContentDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let detailImages = self.model.detailsImages else {
            return 0
        }

        return detailImages.backdrops?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemDetailsCell", for: indexPath) as! ContentDetailsCollectionViewCell
        
        cell.url = self.model.detailsImages.backdrops![indexPath.row].filePath!
        
        return cell
    }
}

extension ContentDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width*0.9, height: view.frame.width*0.8/1.7)
    }
}
