//
//  MonumentSlider.swift
//  wherein
//
//  Created by christophe milliere on 20/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit

class MonumentSlider {
    private var _title: String
    private var _cover: String
    private var _id: String
    private var _lat: String
    private var _lng: String
    private var _category: String
    
    var title: String {
        return _title
    }
    var cover: String {
        return _cover
    }
    var id: String {
        return _id
    }
    var lat: String {
        return _lat
    }
    var lng: String {
        return _lng
    }
    var category: String {
        return _category
    }
    
    init(title: String, cover: String, id: String, lat: String, lng: String, category: String) {
        _title = title
        _cover = cover
        _id = id
        _lat = lat
        _lng = lng
        _category = category
    }
}
