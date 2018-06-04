//
//  MonumentApi.swift
//  wherein
//
//  Created by christophe milliere on 21/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit

struct MonumentApi: Decodable {
    var IDPOI: String?
    var NomPOI: String?
    var Categorie: String?
    var URLImagePrincipale: String?
    var Latitude: String?
    var Longitude: String?
    var HorairesLundi: String?
    var HorairesMardi: String?
    var HorairesMercredi: String?
    var HorairesJeudi: String?
    var HorairesVendredi: String?
    var HorairesSamedi: String?
    var HorairesDimanche: String?
}
