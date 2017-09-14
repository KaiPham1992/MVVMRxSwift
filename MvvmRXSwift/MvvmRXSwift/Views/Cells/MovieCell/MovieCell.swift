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
    @IBOutlet weak var lbPopularity: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var lbGenres: UILabel!
    @IBOutlet weak var vAverage: UIView!
    @IBOutlet weak var lbAverage: UILabel!
    
    var movie: KMovie? {
        didSet{
            vAverage.setBorder(cornerRadius: vAverage.frame.width / 2)
            guard let _movie = movie else { return }
            _movie.getGenres(genresInput: golobalGenres)
            
            imgIcon.setBorder(borderWidth: 1, borderColor: KColor.lineColor, cornerRadius: 5)
            if let urlString =  _movie.posterPath , let url = URL(string: urlString) {
                imgIcon.sd_setImage(with: url, placeholderImage: KImage.imgLoadingPortrait)
            }
            lbMovieTitle.text = _movie.title
            lbOverView.text = _movie.overview
            lbVoteCount.text = _movie.voteCount?.description
            lbPopularity.text = _movie.popularity?.description
            lbReleaseDate.text = _movie.releaseDate?.description
            lbAverage.text = _movie.voteAverage?.description
           lbGenres.text = _movie.genresToString()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        separatorLineView.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
