//
//  MapViewController.swift
//  wherein
//
//  Created by christophe milliere on 10/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit
import NMAKit
import Alamofire

class MapViewController: UIViewController, NMANavigationManagerDelegate {

    @IBOutlet weak var mapView: NMAMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellId = "monumentCell"
    
    var monuments = [MonumentSlider]()
    var monumentApi = [MonumentApi]()
    
    var firstUpdate = true;
    var locationManager: CLLocationManager?
    var locationCurrent: CLLocation?
    var detailController = DetailController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func toControllerView(id: Int) {
        let detailController = DetailController()
        detailController.id = id
        self.present(detailController, animated: true)
//        let VC = detailController(nibName: "DetailController", bundle: nil)
//        VC.id = id
//        present(VC, animated: true, completion: nil)
//        detailController.id = id
//        guard let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailController") as? DetailController else {
//            print("View controller could not be instantiated")
//            return
//        }
//        VC.id = id
//        self.present(VC, animated: true, completion: nil)
//        self.view?.window?.rootViewController?.present(VC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.mapScheme = NMAMapSchemeReducedDay
        //        mapView.useHighResolutionMap = true
        // set some basic values for mapview
        mapView.set(geoCenter: NMAGeoCoordinates(latitude:48.9833, longitude: 1.7167), animation: NMAMapAnimation.bow);
        mapView.zoomLevel = 18.0;
        mapView.tilt = 0.0;
        
        // show the HERe copyright top-middle instead of bottom, since we have the naviagtions buttons on the buttom in this example
        mapView.copyrightLogoPosition = NMALayoutPosition.topCenter;
        
        // show 3D Landmarks / 3D POI models for famous POIs
        mapView.landmarksVisible = true;
        
        // show extruded buildings on closer zoomlevels
        mapView.extrudedBuildingsVisible = true;
        
        // disable all embedded POIs on the map to reduce clutter
        mapView.setVisibility(false, for: NMAMapPoiCategory.all );
        
        // activate traffic - needs plan with traffic included
        mapView.isTrafficVisible = true;
        
        // display speed camera icons on the map
        mapView.safetySpotsVisible = true;
        
        // activate positioning indicator
        mapView.positionIndicator.isVisible = true;
        mapView.positionIndicator.isAccuracyIndicatorVisible = true;
        
        // link mapview instance with guidance for visual updates (otherwise tracking and automatic map updates while guidance won't work)
        NMANavigationManager.sharedInstance().map = mapView;
        
        // decide if navigation should be able to run in the background
        NMANavigationManager.sharedInstance().backgroundNavigationEnabled = false;
        
        // start positioning
        NMAPositioningManager.sharedInstance().startPositioning();
        
        // listen for position updates
        NotificationCenter.default.addObserver(self, selector: #selector(positionDidUpdate), name: NSNotification.Name.NMAPositioningManagerDidUpdatePosition, object: NMAPositioningManager.sharedInstance());
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLosePosition), name: NSNotification.Name.NMAPositioningManagerDidLosePosition, object: NMAPositioningManager.sharedInstance());
    }
    
    @objc func positionDidUpdate(){
        if(firstUpdate){
            let p = NMAPositioningManager.sharedInstance().currentPosition
            //print("Position update received to \(p)");
            
            if p != nil {
                print("Position update received");
                firstUpdate = false;
                mapView.set(geoCenter: (p?.coordinates)!, animation: NMAMapAnimation.bow);
                getMonument(lat: (p?.coordinates?.latitude)!, lng: (p?.coordinates?.longitude)!, id: 1)
            }
            
        }
    }
    
    @objc func didLosePosition(){
        print("Position lost");
    }
    

    func getMonument(lat: Double, lng: Double, id: Int) {
        print("lat \(lat) et lng \(lng)")
        let urlBase = "http://217.160.2.114/BACK_WEB/SqlLiteToSQL/select_poi.php?"
        let key = "key=\(id)"
        let distance = "&distance=\(20)"
        let latitude = "&latitude=\(String(48.866667))"
        let longitude = "&longitude=\(String(2.333333))"
         let urlString = urlBase + key + latitude + longitude + distance
        guard let url  = URL(string: urlString) else { return }
        Alamofire.request(url).responseJSON { (response) in
            let result = response.data
            do{
                self.monumentApi = try JSONDecoder().decode([MonumentApi].self, from: result!)
                for monument in self.monumentApi {
                    let newMonument = MonumentSlider(title: monument.NomPOI!, cover: monument.URLImagePrincipale!, id: monument.IDPOI!, lat: monument.Latitude!, lng: monument.Longitude!, category: monument.Categorie!)
                    self.monuments.append(newMonument)
                }
                self.setupCollectionView()
            } catch {
                print("error")
            }
//            if let datas = response.value as? [String: String] {
//
//            }
        }
    }
}
