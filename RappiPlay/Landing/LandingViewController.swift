//
//  LandingViewController.swift
//  RappiPlay
//
//  Created by Jorge Miranda on 12/10/21.
//

import UIKit

class LandingViewController: UIViewController, LandingDelegate {
    
    
    @IBOutlet weak var mediaSelector: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var popularCollection: UICollectionView!
    @IBOutlet weak var topRatedCollection: UICollectionView!
    @IBOutlet weak var upcomingCollection: UICollectionView!
    
    @IBOutlet weak var TopRatedLabel: UILabel!
    @IBOutlet weak var PopularLabel: UILabel!
    @IBOutlet weak var UpcomingLabel: UILabel!
    
    let refreshTopRatedControl = UIRefreshControl()
    let refreshPopularControl = UIRefreshControl()
    let refreshUpComingControl = UIRefreshControl()
    
    
    let model: LandingModel = LandingModel()
    
    var contentType = MovieService.MediaType.Movie
    
    @IBAction func ContentSegmentChanged(_ sender: UISegmentedControl) {
        
        model.resetContent()
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.contentType = .Movie
        case 1:
            self.contentType = .Tv
        default:
            break
        }
        
        refreshContent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.searchBar.delegate = self
        self.popularCollection.dataSource = self
        self.popularCollection.delegate = self
        
        self.topRatedCollection.dataSource = self
        self.topRatedCollection.delegate = self

        self.upcomingCollection.dataSource = self
        self.upcomingCollection.delegate = self
        
        
        refreshTopRatedControl.addTarget(self, action: #selector(self.refreshTopRatedData), for: UIControl.Event.valueChanged)
        refreshTopRatedControl.attributedTitle = NSAttributedString(string: "Refresh Collection View", attributes: nil)
        refreshTopRatedControl.tintColor = UIColor.label
        self.topRatedCollection.refreshControl = refreshTopRatedControl
        self.topRatedCollection.alwaysBounceHorizontal = true

        
        mediaSelector.setTitle("Movies", forSegmentAt: 0)
        mediaSelector.setTitle("Series", forSegmentAt: 1)
        
        TopRatedLabel.font = UIFont.boldSystemFont(ofSize: 25)
        TopRatedLabel.text = "Top Rated"
        
        PopularLabel.font = UIFont.boldSystemFont(ofSize: 25)
        PopularLabel.text = "Popular"
        
        UpcomingLabel.font = UIFont.boldSystemFont(ofSize: 25)
        UpcomingLabel.text = "Upcoming"
        
        // Call to get the categories from services
        self.model.getUpcoming(for: contentType)
        self.model.getTopRated(for: contentType)
        self.model.getPopular(for: contentType)
        
        //tap gesture implemented to dismiss keyboard
        
        //self.dismissKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBar.text = ""
        self.searchBar.placeholder = "Que quieres vitrinear?"
    }
    
    // function called to update size of CollectionViewCells after change of orientation
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if let layout = popularCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout()
        }
        
        if let layout = topRatedCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout()
        }
        
        if let layout = upcomingCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout()
        }
    }
    
    func refreshContent() {
        self.model.getUpcoming(for: contentType)
        self.model.getTopRated(for: contentType)
        self.model.getPopular(for: contentType)
        
        UpcomingLabel.text = contentType == .Movie ? "Upcoming" : "Airing Today"
    }
    
    @objc func refreshTopRatedData() {
        model.getTopRated(for: contentType)
    }
    
    // MARK: - LandingDelegate
    func refreshUpcoming() {
        //update of category list in main thread
        DispatchQueue.main.async {
            self.upcomingCollection.reloadData()
        }
    }
    
    func refreshPopular() {
        DispatchQueue.main.async {
            self.popularCollection.reloadData()
        }
    }
    
    func refreshTopRated() {
        DispatchQueue.main.async {
            self.topRatedCollection.reloadData()
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? ItemListViewController {
//
//            // Check the format of sender to config the variables for next Vc
//
//            if let senderInfo = sender as? [String:String?] {
//                if let searchQuery = senderInfo["search"]  {
//                    vc.query = searchQuery!
//                }
//            }
//
//            if let senderInfo = sender as? [String:MLServices.MLCategoryDetails] {
//                if let categoryQuery = senderInfo["mediaInfo"] {
//                    vc.categoryInfo = categoryQuery
//                }
//            }
//        }
    }

}

// MARK: - UISearchBarDelegate

extension LandingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // perform segue to item list page with the search query in the sender
        guard !searchBar.text!.isEmpty else {return}
        self.performSegue(withIdentifier: "showItemsList", sender: ["search":searchBar.text])
    }
}


// MARK: - UICollectionViewDelegate

extension LandingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
            case popularCollection:
                return self.model.popularList.count
            case upcomingCollection:
                return self.model.upcomingList.count
            case topRatedCollection:
                return self.model.topRatedList.count
            default:
                return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        var categoryRecords = [MovieService.MovieResult]()
        
        switch collectionView {
            case popularCollection:
                categoryRecords = self.model.popularList
            case upcomingCollection:
                categoryRecords = self.model.upcomingList
            case topRatedCollection:
                categoryRecords = self.model.topRatedList
            default:
                break
        }
        
        guard categoryRecords.count > 0 else {
            return cell
        }
        cell.catInfo = categoryRecords[indexPath.row]
        
        
        if (indexPath.row == categoryRecords.count - 1 ) {
            switch collectionView {
                case popularCollection:
                    self.model.getPopular(for: contentType)
                case upcomingCollection:
                    self.model.getUpcoming(for: contentType)
                case topRatedCollection:
                    self.model.getTopRated(for: contentType)
                default:
                    break
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var categoryRecords = [MovieService.MovieResult]()
        
        switch collectionView {
            case popularCollection:
                categoryRecords = self.model.popularList
            case upcomingCollection:
                categoryRecords = self.model.upcomingList
            case topRatedCollection:
                categoryRecords = self.model.topRatedList
            default:
                break
        }
        
        //self.performSegue(withIdentifier: "showItemsList", sender:["mediaInfo":categoryRecords[indexPath.row]])
    }
    
    
}

extension LandingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.height*0.35*0.66, height: self.view.frame.height*0.35)
    }
}
