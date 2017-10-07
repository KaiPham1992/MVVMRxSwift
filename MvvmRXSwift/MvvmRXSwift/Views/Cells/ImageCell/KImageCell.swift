//
//  KImageCell.swift
//  MvvmRXSwift
//
//  Created by Kai on 10/7/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation

class KImageCell: KBaseCollectionViewCell {
    let imgMovie: UIImageView = {
       let img = UIImageView()
        
        return img
    }()
    
    var imageMovie: KImageMovie? {
        didSet{
            guard let urlStr = imageMovie?.urlPhoto, let url = URL(string: urlStr),
                    let width = imageMovie?.width, let height = imageMovie?.height else {
                return
            }
            let isLandScape = width >  height
            setImage(url: url, isLandScape: isLandScape)
        }
    }
    override func setupViews() {
        self.addSubview(imgMovie)
        imgMovie.fillSuperview()
    }
    
    func setImage(url: URL, isLandScape: Bool = true ) {
        imgMovie.sd_setImage(with: url, placeholderImage: KImage.imgLoadingLandscape)
    }
}
