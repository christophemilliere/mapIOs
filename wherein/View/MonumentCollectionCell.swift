//
//  MonumentCollectionCell.swift
//  wherein
//
//  Created by christophe milliere on 20/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit

class MonumentCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var monumentViewCell: UIView!
    @IBOutlet weak var cover: UIImageView!
    
    var monument: MonumentSlider!
    var mapView = MapViewController()
    
    func setup(monument: MonumentSlider){
        self.monument = monument
        
        monumentViewCell.layer.shadowColor = UIColor.black.cgColor
        monumentViewCell.layer.shadowOpacity = 0.5
        monumentViewCell.layer.shadowOffset = CGSize.zero
        monumentViewCell.layer.cornerRadius = 10
        
        cover.contentMode = .scaleAspectFill
        cover.layer.cornerRadius = 5
        cover.clipsToBounds = true
        cover.isUserInteractionEnabled = true
        let id = Int(monument.id)
        cover.tag = id!
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMe))
        cover.addGestureRecognizer(tap)
        ImageDownloader.getImage.imageSince(monument.cover, imageView: cover)
        
    }
    
    @objc
    func tappedMe(sender: UITapGestureRecognizer){
        print(sender.view!.tag)
        self.mapView.toControllerView(id: (sender.view!.tag))
    }
}
