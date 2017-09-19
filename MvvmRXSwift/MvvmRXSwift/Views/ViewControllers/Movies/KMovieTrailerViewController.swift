//
//  KMovieTrailerViewController.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/18/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import Foundation

class KMovieTrailerViewController: KBaseViewController {
    @IBOutlet weak var cvTrailer: UICollectionView!
    
    var vmMovieTrailer = KMovieTrailerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        
        //---
        vmMovieTrailer.getData()
        bindUI()
    }
    
    func bindUI(){
        bindTrailer()
    }
}

extension KMovieTrailerViewController {
    func bindTrailer(){
        let trailerObs = vmMovieTrailer.trailerResponse.asObservable().map { response -> [KTrailer] in
            guard let _response = response else { return [] }
            return _response.trailers
        }
        
        trailerObs.bind(to: cvTrailer.rx.items) { collectionView, index, trailer in
            let indexPath = IndexPath(item: index, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCell.trailerCell, for: indexPath) as! KTrailerCell
            cell.trailer = trailer
            
            return cell
        }.addDisposableTo(bag)
        
    }
    
}

//---MARK: handle table
extension KMovieTrailerViewController: UICollectionViewDelegateFlowLayout {
    func configureCollection(){
        cvTrailer.delegate = self
        cvTrailer.register(KTrailerCell.self, forCellWithReuseIdentifier: KCell.trailerCell)
        
        cvTrailer.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        if let layout = cvTrailer.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 2
            layout.minimumLineSpacing = 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 2 ) / 2
        let height = 20 + 9 * width / 16
        return CGSize(width: width, height:  height)
    }
    
}
