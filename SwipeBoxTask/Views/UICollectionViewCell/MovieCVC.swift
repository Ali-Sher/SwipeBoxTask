//
//  MovieCVC.swift
//  SwipeBoxTask
//
//  Created by Ali Sher on 14/01/2024.
//

import UIKit
import SDWebImage

class MovieCVC: UICollectionViewCell {
    
    @IBOutlet weak var contantView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var genereLbl: UILabel!
    
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateLbl: UILabel!
    
    var movie: Movie?{
        didSet{
            
            self.configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell() -> Void {
        
        let url_str = "\(Constant.imageBaseURL)\(movie?.poster_path ?? "")"
        let url = URL(string: url_str)
        imgView?.sd_setImage(with: url, placeholderImage: UIImage(named: "movie"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        
        nameLbl.text = movie?.original_title ?? ""
                
        rateLbl.text = String(format: "%0.1f", movie?.vote_average ?? 0.0)
        contantView.layer.cornerRadius = 16
        contantView.clipsToBounds = true
    }
}
