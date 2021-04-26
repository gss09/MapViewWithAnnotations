//
//  ViewController.swift
//  twitterUI
//
//  Created by GSS on 2021-04-25.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstant: NSLayoutConstraint!
    

    // MARK: - Properties
    let viewModel = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* Test data array for tableView
         */
        viewModel.usersArray = [Users(name: "Alison Blake", isFollowing: false,location: viewModel.location1),Users(name: "David Keith", isFollowing: false,location: viewModel.location2),Users(name: "Michael James", isFollowing: false,location: viewModel.location3)]
        tableView.reloadData()
        displayAnnotations()
        
        /* Displays all annotations in the map
         */
        mapView.fitAll()
        
        tableView.estimatedRowHeight = 61
        tableViewHeightConstant.constant = tableView.estimatedRowHeight * CGFloat(viewModel.usersArray.count)
    }


    // MARK: - Add annotations to the mapView
    func displayAnnotations(){
        
        /* Add annotations to the map
         */
        
        for user in viewModel.usersArray{
            viewModel.addAnnotationToMapView(location: user.location, mapView: mapView, name: user.name)
        }
    }
    
}

