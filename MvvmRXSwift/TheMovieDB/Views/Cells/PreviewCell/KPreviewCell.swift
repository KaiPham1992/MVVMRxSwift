//
//  KPreviewCell.swift
//  TheMovieDB
//
//  Created by Kai on 10/22/17.
//  Copyright © 2017 Kai. All rights reserved.
//


import UIKit
import SDWebImage


class PreviewPhotoCell : KBaseCollectionViewCell {
    let imgPhoto: UIImageView = {
        let img = UIImageView()
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.image = KImage.imgLoadingLandscape
        
        return img
    }()
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.maximumZoomScale = 5
        scroll.minimumZoomScale = 1
        scroll.clipsToBounds = true
        return scroll
    }()
    
    let vImage: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var image: Any? {
        didSet {
            if let _image =  image as? KImageMovie, let urlStr = _image.urlPhoto, let url = URL(string: urlStr) {
                imgPhoto.sd_setImage(with: url, placeholderImage: KImage.imgLoadingLandscape)
            }
           
            
        }
    }
    
    override func setupViews() {
        scrollView.delegate = self
        addSubview(scrollView)
        scrollView.fillSuperview()
        let tap = UITapGestureRecognizer(target: self , action:  #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(tap)
        //---
        scrollView.addSubview(vImage)
        vImage.fillSuperview()
        vImage.centerSuperview()
        //---
        vImage.addSubview(imgPhoto)
        imgPhoto.fillSuperview()
        
        
    }
    
    func doubleTapped(gesture: UITapGestureRecognizer){
        self.scrollView.zoomScale = 1.0
    }
}
extension PreviewPhotoCell : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgPhoto
        
    }
}

