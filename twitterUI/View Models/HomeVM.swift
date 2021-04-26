//
//  HomeVM.swift
//  twitterUI
//
//  Created by GSS on 2021-04-25.
//

import UIKit
import CoreLocation
import MapKit

class HomeVM{
    // MARK: - Properties
    var usersArray = [Users]()
    
    /* Sample locations
     */
    var location1 = CLLocationCoordinate2D(latitude: 43.662051, longitude: -79.393856)
    var location2 = CLLocationCoordinate2D(latitude: 45.591127, longitude: -75.739472)
    var location3 = CLLocationCoordinate2D(latitude: 45.756174, longitude: -73.036836)
    
    
    // MARK: - Add annotations to mapView
    /**
     Add annotations to mapView
     - Parameters :
     - location: location of the region
     - mapView: mapView to draw circular regions
     */
    func addAnnotationToMapView(location: CLLocationCoordinate2D, mapView:MKMapView,name:String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = name
        mapView.addAnnotation(annotation)
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath) as! UsersCell
        
        /* Update cell with the values from local array
         */
        
        cell.update(with: viewModel.usersArray[indexPath.row])

        // Button action for follow user
        cell.followButton.addTarget(self, action: #selector(followButtonTapped(_:)), for: .touchUpInside)
        cell.followButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    //MARK: - Follow users
    @objc func followButtonTapped(_ sender:UIButton?){
        
        guard let row = sender?.tag else {
            return
        }
        
        /* Change button text to following, update table row
         */
        if !viewModel.usersArray[row].isFollowing{
            viewModel.usersArray[row].isFollowing = !viewModel.usersArray[row].isFollowing
        }
        
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }
    
}

extension HomeViewController:CLLocationManagerDelegate,MKMapViewDelegate{
    
    // MARK: - CLLocationManagerDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        /* Add image to annotations
         */
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = (annotation.title ?? "")?.getImageFromText()
        annotationView.canShowCallout = true
        
        return annotationView
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager failed with error: \(error.localizedDescription)")
    }
}


struct Users {
    var name = ""
    var isFollowing = false
    var location = CLLocationCoordinate2D()
}
