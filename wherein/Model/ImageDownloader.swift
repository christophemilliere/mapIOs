//
//  ImageDownloader.swift
//  wherein
//
//  Created by christophe milliere on 20/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit

class ImageDownloader {
    static let getImage = ImageDownloader()
    func imageSince(_ urlImage: String, imageView: UIImageView){
        
        if let url = URL(string: urlImage) {
            print(url)
            let session = URLSession.shared
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                guard data != nil, let image = UIImage(data: data!) else { return }
                DispatchQueue.main.async {
                    imageView.image = image
                }
            })
            task.resume()
        }
    }
}
