//
//  KPhotoViewController.swift
//  MvvmRXSwift
//
//  Created by Kai on 10/2/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit

class KMovieImageViewController: KBaseViewController {
    @IBOutlet weak var cvImage: UICollectionView!
    var vmMovieImage = KMovieImageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        
        vmMovieImage.getData()
        bindUI()
    }
}

//---MARK:  bindUI
extension KMovieImageViewController {
    func bindUI(){
        bindImage()
    }
    
    func bindImage(){
        //--- get backdrop from reponse
        let imageBackdrop = vmMovieImage.images.asObservable().map { imageResponse -> [KImageMovie] in
            guard let _imageResponse = imageResponse else { return [] }
            return _imageResponse.backdrops
        }
        //--- get poster from reponse
        let imagePoster = vmMovieImage.images.asObservable().map { imageResponse -> [KImageMovie] in
            guard let _imageResponse = imageResponse else { return [] }
            return _imageResponse.posters
        }
        
        //---
        let images = imageBackdrop.concat(imagePoster)
        images.bind(to: cvImage.rx.items){ collection, index, image in
            let indexPath = IndexPath(item: index, section: 0)
            let cell = collection.dequeueReusableCell(withReuseIdentifier: KCell.imageCell, for: indexPath) as! KImageCell
            cell.imageMovie = image
            
            return cell
        }.addDisposableTo(bag)
        
    }
}

//---MARK:  UICollectionView
extension KMovieImageViewController: UICollectionViewDelegateFlowLayout {
    func configureCollection(){
        cvImage.delegate = self
        cvImage.register(KImageCell.self, forCellWithReuseIdentifier: KCell.imageCell)
        
        cvImage.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        if let layout = cvImage.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 2
            layout.minimumLineSpacing = 2
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 2) / 2
        
        return CGSize(width: width, height: 100)
    }
}
