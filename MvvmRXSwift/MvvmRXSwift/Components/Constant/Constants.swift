//
//  Constants.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/8/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit


public let BASE_URL = "https://api.themoviedb.org/3/"
public let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/w500/"
public let MOVIEDB_API_KEY = "f7b6a27fedf4a430dd71f5a7e8bec2a5"
public let BASE_IMAGE_URL_LANSCAPE = "https://image.tmdb.org/t/p/w500_and_h281_bestv2/"


struct KColor {
    static let redColor = UIColor(red: 207/255, green: 15/255, blue: 37/255, alpha: 1)
    static let yellowColor = UIColor(red: 254/255, green: 246/255, blue: 163/255, alpha: 1)
    static let blueColor = UIColor(red: 0/255, green: 200/255, blue: 250/255, alpha: 1)
    static let background = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    static let grayColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    static let whiteColor = UIColor.white
    static let backgroundPopUp =  UIColor.black.withAlphaComponent(0.5)
    static let backgroundIndicator = UIColor.black.withAlphaComponent(0.5)
    static let blackColor = UIColor.black

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
}
