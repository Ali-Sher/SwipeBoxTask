//
//  HomeViewModel.swift
//  SwipeBoxTask
//
//  Created by Ali Sher on 14/01/2024.
//

import Foundation
import CoreData
import UIKit

class HomeViewModel {
    
    public static let shared = HomeViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getPopular(page: Int, completion: @escaping (MovieModel?) -> ()) {
        
        let parameter = ["api_key": "\(Constant.KeyV3)", "page": page] as [String : Any]
        
        let url = ApiUrls.popularMoviesApi
        let apiManager = ApiManager()
        apiManager.WebService1(url: url, parameter: parameter, method: .get, encoding: .queryString, {[weak self] responseData in
            do {
                
                let response = try JSONDecoder().decode(MovieModel.self, from: responseData)
                
                if page == 1 {
                    
                    self?.deleteLocalMovies()
                }
                self?.saveMoviesLocally(movies: response.results ?? [])
                
                completion(response)
                
            } catch{
                print(error.localizedDescription)
                completion(nil)
            }
        }) { error in
            
            print("error")
        }
    }
    
    //MARK: Local DB
    
    /// get movies from local DB
    func getMoviesLocally(completion: @escaping([Movie]) -> Void) {
        
        do {
            let localMoviesList = try context.fetch(MovieDB.fetchRequest())
            
            var movies = [Movie]()
            for movie in localMoviesList {
                
                var m = Movie()
                m.id = Int(movie.id)
                m.original_title = movie.original_title
                m.poster_path = movie.poster_path
                m.vote_average = movie.vote_average
                m.overview = movie.overview
                
                movies.append(m)
            }
            
            completion(movies)
        } catch {
            print(error.localizedDescription)
            completion([])
        }
    }
    
    
    /// save movies local DB
    private func saveMoviesLocally(movies: [Movie]) -> Void {
        
        for movieData in movies {
            
            // Create a new MovieDB managed object
            let movieEntity = NSEntityDescription.entity(forEntityName: "MovieDB", in: context)!
            let movie = NSManagedObject(entity: movieEntity, insertInto: context) as! MovieDB
            
            // Configure the movie object with data
            movie.id = Int64(movieData.id ?? 0)
            movie.poster_path = movieData.poster_path ?? ""
            movie.original_title = movieData.original_title ?? ""
            movie.vote_average = movieData.vote_average ?? 0.0
            movie.overview = movieData.overview ?? ""
            
            // Save the context
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save movie. \(error), \(error.userInfo)")
            }
        }
    }
    
    
    /// delete movies from local DB
    private func deleteLocalMovies() -> Void {
        
        do {
            let moviesList = try context.fetch(MovieDB.fetchRequest())
            for movie in moviesList {
                
                self.context.delete(movie)
            }
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
