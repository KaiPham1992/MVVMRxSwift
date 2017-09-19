//
//  KTrailerView.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/18/17.
//  Copyright © 2017 Kai. All rights reserved.
//


import YouTubePlayer

class KTrailerCell: KBaseCollectionViewCell {
    
    let imgThumbnail: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let imgPlay: UIImageView = {
        let view = UIImageView()
        view.image = KImage.imgPlay
        
        return view
    }()
    
    let vContent: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let lbName: UILabel = {
        let lb = UILabel()
        lb.font = KFont.fontRegular13
        
        return lb
    }()
    
    var trailer: KTrailer? {
        didSet{
            guard let _trailer = trailer, let thumbnail = _trailer.thumbnail, let url = URL(string: thumbnail) else { return }
            
            imgThumbnail.sd_setImage(with: url, placeholderImage: KImage.imgLoadingPortrait)
            
            lbName.text = _trailer.name
        }
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = KColor.whiteColor
        setBorder(borderWidth: 1, borderColor: KColor.lineColor, cornerRadius: 0)
        
        //---
        addSubview(imgThumbnail)
        addSubview(imgPlay)
        addSubview(vContent)
        vContent.addSubview(lbName)
        
        vContent.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 20)
        
        //---
        imgThumbnail.anchor(topAnchor, left: leftAnchor, bottom: vContent.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //---
        imgPlay.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant:0, widthConstant: 30, heightConstant: 30)
        imgPlay.centerToView(view: imgThumbnail)
        
        //---
        lbName.fillSuperview()
    }
}
