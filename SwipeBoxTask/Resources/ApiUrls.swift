//
//  ApiUrls.swift
//  SwipeBoxTask
//
//  Created by Ali Sher on 14/01/2024.
//

import Foundation

class ApiUrls: NSObject {
    
    public static var BaseDomain3 = Constant.BaseURLV3
    
    
    public static var popularMoviesApi = BaseDomain3 + "movie/popular"
    public static var movieDetailApi = BaseDomain3 + "movie/%d"
}
