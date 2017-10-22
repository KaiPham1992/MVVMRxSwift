//
//  KPreviewPhotoViewController.swift
//  TheMovieDB
//
//  Created by Kai on 10/22/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit

class KPreviewPhotoViewController: KBaseViewController {
    
    var listImage = [Any]()
    var indexSelected: Int?
    let cellId = "cellId"
    var olderIndex  = 0
    
    lazy var cvImage: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = KColor.navigationColor
        
        return cv
    }()
    
    lazy var btnClose: UIButton = {
        let btn = UIButton()
        btn.setImage(KImage.imgClose, for: .normal)
        btn.addTarget(self , action: #selector(btnCloseClicked), for: .touchUpInside)
        return btn
    }()
    
    let lbCount: UILabel = {
        let lb = UILabel()
        lb.textColor = KColor.whiteColor
        lb.font = KFont.fontBold17
        lb.text = "kai test test test "
        lb.textAlignment = .center
        
        return lb
    }()
    
    let vTop: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureCollection()
    }
    
    override func setupNavigation() {
        super.setupNavigation()
        addCloseToNavigation()
    }
    
    func setupView(){
        self.olderIndex = indexSelected ?? 0
        
        //---
        self.view.backgroundColor = KColor.navigationColor
        self.view.addSubview(vTop)
        self.vTop.addSubview(btnClose)
        self.vTop.addSubview(lbCount)
        self.view.addSubview(cvImage)
        
        //---
        vTop.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)
        
        btnClose.centerYToSuperview()
        btnClose.widthAnchor.constraint(equalToConstant: 44).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnClose.leftAnchor.constraint(equalTo: vTop.leftAnchor, constant: 10).isActive = true
        
        lbCount.centerYToSuperview()
        lbCount.fillHorizontalSuperview()
        
        cvImage.anchor(vTop.bottomAnchor, left: vTop.leftAnchor, bottom: view.bottomAnchor, right: vTop.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    func configureCollection() {
        cvImage.register(PreviewPhotoCell.self , forCellWithReuseIdentifier: cellId)
        cvImage.isPagingEnabled = true
        if let _indexSelected = indexSelected {
            let indexPath = IndexPath(item: _indexSelected, section: 0)
            cvImage.scrollToItem(at: indexPath, at: .left, animated: true)
            setTextPositionPhoto(index: _indexSelected)
        }
    }
    
    
}


//Action
extension KPreviewPhotoViewController {
    func btnCloseClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setDefaultZoom(index: Int){
        let indexPath = IndexPath(item: index, section: 0)
        let cellCurrent = cvImage.cellForItem(at: indexPath) as? PreviewPhotoCell
        if let cell = cellCurrent {
            cell.scrollView.zoomScale = 1.0
        }
    }
    
    func setTextPositionPhoto(index: Int){
        let item = index + 1
        lbCount.text = "\(item)/ \(self.listImage.count)"
    }
}

// Handle Collection
extension KPreviewPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImage.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PreviewPhotoCell
        cell.image = listImage[indexPath.item]
        cell.backgroundColor = KColor.navigationColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index: Int = Int(targetContentOffset.pointee.x / cvImage.frame.width)
        
        self.setTextPositionPhoto(index: index)
        setDefaultZoom(index: olderIndex)
        olderIndex = index
    }
    
}
