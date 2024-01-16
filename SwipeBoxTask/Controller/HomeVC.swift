//
//  HomeVC.swift
//  SwipeBoxTask
//
//  Created by Ali Sher on 14/01/2024.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var moviesCV: UICollectionView!
    
    var moviesList: [Movie] = []
    var pageNo = 1
    var isRecordsEnds = false
    var isConnected = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCV.backgroundColor = .clear
        moviesCV.register(UINib(nibName: "MovieCVC", bundle: nil), forCellWithReuseIdentifier: "MovieCVC")
        
        errorLbl.isHidden = true
        moviesCV.isHidden = true
        spinner.isHidden = false
        spinner.startAnimating()
        
        checkNetworkStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func checkNetworkStatus() {
        
        guard NetworkManager.shared.isDeviceConnected() else {
            
            isConnected = false
            HomeViewModel.shared.getMoviesLocally {[weak self] response in
                
                self?.moviesCV.isHidden = false
                self?.spinner.isHidden = true
                
                self?.moviesList = response
                if self?.moviesList.count == 0 {
                    
                    self?.errorLbl.isHidden = false
                    self?.moviesCV.isHidden = true
                }
                
                self?.moviesCV.reloadData()
            }
            
            return
        }
        
        isConnected = true
        self.getMovies()
    }
    
    func getMovies() -> Void {
        
        HomeViewModel.shared.getPopular(page: pageNo) {[weak self] response in
            
            self?.moviesCV.isHidden = false
            self?.spinner.isHidden = true
            
            guard let res = response else {
                
                if self?.moviesList.count == 0 {
                    
                    self?.errorLbl.isHidden = false
                    self?.moviesCV.isHidden = true
                }
                return
            }
            
            self?.moviesList.append(contentsOf: res.results ?? [])
            if self?.moviesList.count == res.total_results {
                
                self?.isRecordsEnds = true
            }
            
            self?.moviesCV.reloadData()
        }
    }
}

//MARK: CollectionView
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.moviesList.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var width = self.view.frame.size.width - 32
        width /= 2
        
        return CGSize(width: width, height: width + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : MovieCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVC", for: indexPath) as! MovieCVC
        
        cell.movie = moviesList[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard isConnected else { return }
        
        if indexPath.item == moviesList.count - 1 && !isRecordsEnds {
            
            pageNo += 1
            self.getMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = moviesList[indexPath.item]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        
        vc.movie = movie
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
