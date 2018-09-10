//
//  VideoResultCell.swift
//  VeedYo
//
//  Created by Sidhant Chadha on 9/7/18.
//  Copyright © 2018 AMoDynamics, Inc. All rights reserved.
//

import UIKit
import Hero

class VideoResultCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailDisp: UIImageView!
    

    @IBOutlet weak var videotitleDisp: UILabel!
    
    func setVideo(video : Snippet) {
        videotitleDisp.text = video.title
        let imageURL =  URL(string: video.thumbnails.medium.url)
        let data = try? Data(contentsOf: imageURL!)
        let image = UIImage(data: data!)
        
        thumbnailDisp.image = image
        //thumbnailDisp.hero.id = "abc"
        //thumbnailDisp.hero.modifiers = [.spring(stiffness: 250, damping: 25)]
        //thumbnailDisp.hero.modifiers = [.fade, .translate(x:0, y:-250), .rotate(x:-1.6), .scale(1.5)]

    }
    
}
