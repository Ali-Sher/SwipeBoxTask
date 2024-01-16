//
//  MovieDetailsVC.swift
//  SwipeBoxTask
//
//  Created by Ali Sher on 14/01/2024.
//

import UIKit
import SDWebImage

class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak var dataScrollView: UIScrollView!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    
    var movie: Movie?
    var movieDetails: MovieDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        
        if NetworkManager.shared.isDeviceConnected() {
            
            getMovieDetails(id: movie?.id ?? 0)
        }else {
            
            movieDetails = MovieDetails()
            movieDetails?.id = movie?.id
            movieDetails?.poster_path = movie?.poster_path
            movieDetails?.original_title = movie?.original_title
            movieDetails?.vote_average = movie?.vote_average
            movieDetails?.overview = movie?.overview
            
            self.setData()
        }
    }
    

    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func getMovieDetails(id: Int) -> Void {
        
        MovieDetailsViewModel.shared.getMovieDetails(id: id) {[weak self] response in
            
            guard let res = response else {
                
                self?.dataScrollView.isHidden = true
                self?.errorLbl.isHidden = false
                return
            }
            
            self?.movieDetails = res
            self?.setData()
        }
    }
    
    func setData() -> Void {
        
        let url_str = "\(Constant.imageBaseURL)\(movieDetails?.poster_path ?? "")"
        let url = URL(string: url_str)
        imgView?.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        
        let title = movieDetails?.original_title ?? ""
        nameLbl.text = title
        
        let rate = movieDetails?.vote_average ?? 0.0
        ratingLbl.text = String(format: "%0.1f", rate)
        
        let overview = movieDetails?.overview ?? ""
        overviewLbl.text = overview
    }
}
