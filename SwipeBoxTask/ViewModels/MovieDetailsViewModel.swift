//
//  MovieDetailsViewModel.swift
//  SwipeBoxTask
//
//  Created by Ali Sher on 14/01/2024.
//

import Foundation

class MovieDetailsViewModel {
    
    public static let shared = MovieDetailsViewModel()
    
    //MARK: Get Movie Details
    func getMovieDetails(id: Int, completion: @escaping (MovieDetails?) -> ()) {
        
        let parameter = ["api_key": "\(Constant.KeyV3)"] as [String: Any]
        
        let url = String(format: ApiUrls.movieDetailApi, id)
        let apiManager = ApiManager()
        
        apiManager.WebService1(url: url, parameter: parameter, method: .get, encoding: .queryString, { responseData in
            do {
                
                let response = try JSONDecoder().decode(MovieDetails.self, from: responseData)
                print(response)
                completion(response)
                
            } catch{
                print(error.localizedDescription)
                completion(nil)
            }
        }) { error in
            
            print("error")
        }
    }
}
