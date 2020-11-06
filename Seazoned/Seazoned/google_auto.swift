//
//  google_auto.swift
//  Seazoned
//
//  Created by apple on 27/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GooglePlacesSearchController
import GoogleMaps
import GooglePlaces
protocol trasfardata {
    func addresssend(add:String,city:String,country:String,zipcode:String,state:String)
    func fetchlatlong(lat:String,long:String)
}
class google_auto: UIViewController,GMSAutocompleteViewControllerDelegate {

    
    var flag : String = ""
    var delegate:trasfardata!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.white
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        // Do any additional setup after loading the view.
        
        
      //  self.navigationController?.isNavigationBarHidden=true
        
        //        let controller = GooglePlacesSearchController(
        //            apiKey: GoogleMapsAPIServerKey,
        //            placeType: PlaceType.address
        //        )
        
        //        Or if you want to use autocompletion for specific coordinate and radius (in meters)
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        
        // self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        
    }
    let GoogleMapsAPIServerKey = "AIzaSyDJvNKFF3zHyOKcuSWzJ2RFMQV1Eu3gihI"
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if flag == "1"
        {
            
            self.navigationController?.popViewController(animated: true)
        }
        
        else
        {
            
        }
        
    }
    
    
    @IBAction func searchAddress(_ sender: Any) {
        
        //        let controller = GooglePlacesSearchController(
        //            apiKey: GoogleMapsAPIServerKey,
        //            placeType: PlaceType.address
        //        )
        
        //        Or if you want to use autocompletion for specific coordinate and radius (in meters)
        let coord = CLLocationCoordinate2D(latitude: 22.5726, longitude: 88.3639)
        let controller = GooglePlacesSearchController(
            apiKey: GoogleMapsAPIServerKey,
            placeType: PlaceType.all,
            coordinate: coord,
            radius: 10
        )
        
        controller.didSelectGooglePlace { (place) -> Void in
            print(place.formattedAddress)
            print("---\(place.country)")
            print("--\(place.locality)")
            print("-\(place.postalCode)")
            print("-----\(place.administrativeArea)")
            
            print("-----\(place.subAdministrativeArea)")
            
            print("--sss---\(place.coordinate.latitude)")
            print("--sss---\(place.coordinate.longitude)")
            
          //  let str = place.name + ", " + place.formattedAddress
            
            let str =   place.formattedAddress

            
            self.delegate.addresssend(add: str, city: place.locality, country: place.country, zipcode: place.postalCode, state: place.administrativeArea)
            self.delegate.fetchlatlong(lat: String(place.coordinate.latitude), long: String(place.coordinate.longitude))
            //Dismiss Search
            controller.isActive = false
            self.navigationController?.popViewController(animated: true)
        }
        
        present(controller, animated: true, completion: nil)
    }
   

    @IBAction func cancel(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: GOOGLE AUTO COMPLETE DELEGATE
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
     //   let lat = place.coordinate.latitude
    //    let long = place.coordinate.longitude
       // print(lat)
           let str =   place.formattedAddress
        
        
        var countryName : String = ""
        var cityname : String = ""
        var zipname : String = ""
        var  statename :  String = ""


        
        if let addressComponents = place.addressComponents,let countryComponent = (addressComponents.filter { $0.type == "country" }.first) {
             countryName = countryComponent.name
            print("Country::::::::\(countryName)")
        }
        
        if let addressComponents = place.addressComponents,let cityComponent = (addressComponents.filter { $0.type == "administrative_area_level_2" }.first) {
             cityname = cityComponent.name
            print("city::::::::\(cityname)")
        }
        
        if let addressComponents = place.addressComponents,let zipComponent = (addressComponents.filter { $0.type == "post_box" }.first) {
             zipname = zipComponent.name
            print("zip::::::::\(zipname)")
        }
        
        if let addressComponents = place.addressComponents,let stateComponent = (addressComponents.filter { $0.type == "administrative_area_level_1" }.first) {
             statename = stateComponent.name
            print("state::::::::\(statename)")
        }
   // print("--=======\(place.addressComponents)")
        
        
       self.delegate.addresssend(add: str!, city: cityname, country: countryName, zipcode: zipname, state: statename)
        self.delegate.fetchlatlong(lat: String(place.coordinate.latitude), long: String(place.coordinate.longitude))
        
        
        
        //  showPartyMarkers(lat: lat, long: long)
        //        gps_show(lat: lat, long: long)
//        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
//        myMapView.camera = camera
//
//        if flag == 1
//        {
//            locationstart = CLLocation (latitude: lat, longitude: long)
//            pickup_latitude = "\(place.coordinate.latitude)"
//            pickup_longitude = "\(place.coordinate.longitude)"
//            print(locationstart)
      //  txt_pickup.text=place.formattedAddress
        
      
//
//            gps_show(lat: lat, long: long)
//        }
//
//        else
//        {
//            locationend = CLLocation (latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
//            des_lat = "\(place.coordinate.latitude)"
//            des_long = "\(place.coordinate.longitude)"
//            print(locationend)
//            txt_drop.text=place.formattedAddress
//
//            gps_show2(lat: place.coordinate.latitude, long: place.coordinate.longitude)
//
//            self.Distance_matrix(startlocation: locationstart, endlocation: locationend)
//
//        }
//        //  chosenPlace = MyPlace(name: place.formattedAddress!, lat: lat, long: long)
//        let marker=GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        marker.title = "\(place.name)"
//        marker.snippet = "\(place.formattedAddress!)"
//
        
        
        
    
        self.dismiss(animated: true, completion: nil) // dismiss after place selected
        
         flag = "1"
    }
    //    @objc func fff()  {
    //        progressView.removeFromSuperview()
    //        progressView = BLEProgressView()
    //    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
        
        flag = "1"
    }
}
