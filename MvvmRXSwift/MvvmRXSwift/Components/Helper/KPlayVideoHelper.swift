//
//  KPlayVideoHelper.swift
//  MvvmRXSwift
//
//  Created by Kai on 9/16/17.
//  Copyright © 2017 Kai. All rights reserved.
//

import AVFoundation
import AVKit

class KPlayerVideoHelper {
    
    static let shared = KPlayerVideoHelper()
    
    func showVideo(urlString: String, vcCurrent: UIViewController) {
//        let vc = UIApplication.topViewController()
//        guard let vcCurrent = vc else { return }
        
        //---
        guard let url = URL(string: urlString) else { return }
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        
        vcCurrent.present(playerViewController, animated: true, completion: {
            playerViewController.player?.play()
        })
    }
}
