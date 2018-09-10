//
//  PlaybackViewController.swift
//  VeedYo
//
//  Created by Sidhant Chadha on 9/7/18.
//  Copyright © 2018 AMoDynamics, Inc. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import Hero

class PlaybackViewController: UIViewController, YTPlayerViewDelegate {

    var video : Item?
    var videoID : String?
    let playbackView = YTPlayerView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        playbackView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        playbackView.delegate = self
        playbackView.frame = CGRect(x: 0, y: 0, width: 365, height: 320)
        playbackView.center = self.view.center
        
       
        
        view.addSubview(playbackView)
        videoID = video?.id.videoID
        playbackView.load(withVideoId: self.videoID!)
        playbackView.hero.id = "abc"
        playbackView.hero.modifiers = [.spring(stiffness: 250, damping: 25)]
        //let playerVars = ["playsinline": 1]

    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
       
        playerView.playVideo()
        
    }
    
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        let translation = gr.translation(in: view)
        switch gr.state {
        case .began:
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(translation.y / view.bounds.height)
        default:
            let velocity = gr.velocity(in: view)
            if ((translation.y + velocity.y) / view.bounds.height) > 0.5 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    


}
