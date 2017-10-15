//
//  Constants.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit


public let BASE_URL = "https://api.themoviedb.org/3"
public let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/w500"
public let API_KEY = "f7b6a27fedf4a430dd71f5a7e8bec2a5"

public let BASE_IMAGE_YOUTUBE = "https://i.ytimg.com/vi/{id}/hqdefault.jpg"
public let BASE_VIDEO_YOUTUBE = "http://www.youtube.com/get_video_info?video_id={id}"
var appMovieGenres = [KGenre]()


struct KColor {
    static let navigationColor = UIColor(red: 51/255, green: 51/255, blue: 56/255, alpha: 1)
    static let background = UIColor(red: 240/255, green: 244/255, blue: 244/255, alpha: 1)
    static let yellowColor = UIColor(red: 255/255, green: 205/255, blue: 0/255, alpha: 1)
    static let lineColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    
    //---
    static let smallTextColor = UIColor(red: 155/255, green: 163/255, blue: 158/255, alpha: 1)
    static let normalTextColor = UIColor(red: 51/255, green: 51/255, blue: 56/255, alpha: 1)
    static let whiteColor = UIColor.white
    
    
    static let blueColor = UIColor(red: 0/255, green: 200/255, blue: 250/255, alpha: 1)
    static let backgroundPopUp =  UIColor.black.withAlphaComponent(0.5)
    static let backgroundIndicator = UIColor.black.withAlphaComponent(0.5)
}

struct KFont {
    static let fontBold27: UIFont = UIFont(name: "Calibri-Bold", size: 25)!
    static let fontRegular27: UIFont = KDevie.getTypeDevice() == TypeDevice.SMALL ? UIFont(name: "Calibri", size: 25)!: UIFont(name: "Calibri", size: 27)!
    
    static let fontRegular17: UIFont = KDevie.getTypeDevice() == TypeDevice.SMALL ? UIFont(name: "Calibri", size: 15)! : UIFont(name: "Calibri", size: 17)!
    static let fontBold17: UIFont = KDevie.getTypeDevice() == TypeDevice.SMALL ? UIFont(name: "Calibri-Bold", size: 15)!: UIFont(name: "Calibri-Bold", size: 17)!
    
    static let fontRegular15: UIFont = KDevie.getTypeDevice() == TypeDevice.SMALL ? UIFont(name: "Calibri", size: 13)! : UIFont(name: "Calibri", size: 15)!
    static let fontBold15: UIFont = KDevie.getTypeDevice() == TypeDevice.SMALL ? UIFont(name: "Calibri-Bold", size: 13)! : UIFont(name: "Calibri-Bold", size: 15)!
    
    static let fontRegular13: UIFont = KDevie.getTypeDevice() == TypeDevice.SMALL ? UIFont(name: "Calibri", size: 11)! : UIFont(name: "Calibri", size: 13)!
    static let fontBold13: UIFont = KDevie.getTypeDevice() == TypeDevice.SMALL ? UIFont(name: "Calibri-Bold", size: 11)!: UIFont(name: "Calibri-Bold", size: 13)!
}

struct KImage {
    static let imgBack = UIImage(named: "back")!
    static let imgClose = UIImage(named: "close")!
    static let imgCategory = UIImage(named: "category")!
    static let imgLoadingPortrait = UIImage(named: "placeholder_l")!
    static let imgLoadingLandscape = UIImage(named: "placeholder_sq")!
    static let imgPlay = UIImage(named: "play")!
    
    
    
    //--- tabbar
    static let imgTabMovieNomarl = UIImage(named: "movie")!.withRenderingMode(.alwaysOriginal)
}

struct KCell {
    static let movieCell = "MovieCell"
    static let trailerCell = "KTrailerViewCell"
    static let imageCell = "KImageCell"
}
