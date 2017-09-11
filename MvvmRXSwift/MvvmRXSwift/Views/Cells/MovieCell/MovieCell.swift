//
//  MovieCell.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/10/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: KBaseTableViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var lbOverView: UILabel!
    @IBOutlet weak var lbVoteCount: UILabel!
    
    var movie: KMovie? {
        didSet{
            guard let _movie = movie else { return }
            imgIcon.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 5)
            if let urlString =  _movie.posterPath , let url = URL(string: urlString) {
                imgIcon.sd_setImage(with: url, placeholderImage: KImage.imgLoadingPortrait)
            }
            lbMovieTitle.text = _movie.title
            lbOverView.text = _movie.overview
            lbVoteCount.text = _movie.voteCount?.description
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
