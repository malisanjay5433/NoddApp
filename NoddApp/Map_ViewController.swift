//
//  ViewController.swift
//  NoddApp
//
//  Created by Sanjay Mali on 07/10/16.
//  Copyright © 2016 Sanjay. All rights reserved.
//

import UIKit
import SwiftyJSON
import  GoogleMaps
class Map_ViewController: UIViewController,CLLocationManagerDelegate , GMSMapViewDelegate {
    var m = [Model]()
    var locationManager: CLLocationManager!
    var didanimateCamera:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "NoddApp"
        Loader.inst.startLoading()
        readJSON()
        view.backgroundColor = UIColor.gray
        let c = GMSCameraPosition.camera(withLatitude:19.0760, longitude:72.4777, zoom: 7)
        map_View = GMSMapView.map(withFrame: .zero, camera: c)
        view = map_View
        map_View.delegate = self
        constrain()
        get()
        Loader.inst.endLoading()
    }
    
    func constrain(){
        
        map_View.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        map_View.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        map_View.heightAnchor.constraint(equalTo:view.heightAnchor).isActive = true
        map_View.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
    }
    
    var map_View: GMSMapView = {
        let view = GMSMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func readJSON(){
        if let path : String = Bundle.main.path(forResource: "JSONFile", ofType: "txt") {
            if let data = NSData(contentsOfFile: path) {
                let json = JSON(data: data as Data)
                let data = json["data"].array!
                for i in data {
                    let title = i["title"].string
                    let type = i["type"].string
                    let cor = i ["coordinate"].string!
                    let coordinate = cor.components(separatedBy:",")
                    let lat = coordinate[0]
                    let lon = coordinate[1]
                    let  response = Model(type:type!,title:title!,lat:lat,lon:lon)
                    self.m.append(response)
                    
                }
            }
            
        }
    }
    func get(){
        for index in self.m {
            self.setMarkersOnMap((index.lat as NSString).doubleValue, lng: (index.lon as NSString).doubleValue, title: index.type, snipet:"", item: index)
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let vc = Detailed_ViewController()
        print("didTapInfoWindowOf")
        let model = marker.userData as! Model
        
        vc.nType = model.type
        vc.nEvent = model.title
        vc.nlatlong = model.lat + "," + model.lon
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func setMarkersOnMap(_ lat: Double, lng: Double , title: String , snipet: String, item:Model) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lat, lng)
        if item.type == "ex"{
            marker.title = title
            marker.isFlat = true
            marker.icon = UIImage(named: "red")
            marker.map = map_View
            marker.userData = item
            
        }else if item.type == "pe"{
            marker.title = title
            marker.isFlat = true
            marker.icon = UIImage(named: "voilet")
            marker.map = map_View
            marker.userData = item
            
        }else{
            marker.title = title
            marker.isFlat = true
            marker.icon = UIImage(named: "black")
            marker.map = map_View
            marker.userData = item
            
        }
        
    }
}
