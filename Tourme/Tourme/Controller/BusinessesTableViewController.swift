//
//  BusinessesTableViewController.swift
//  Tourme
//
//  Created by Dua Almahyani on 24/12/2020.
//

import UIKit
import CoreLocation

private let reuseIdentifier = "BusinessCell"

class BusinessesTableViewController: UITableViewController {
    

    
    let locationManger = CLLocationManager()
    var yelpManger = YelpManger()
    
    var businesses = [Business]()
    var utility = Utilities()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(mainTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorColor = .clear
        
        yelpManger.delegate = self
        
        setupLocationManger()
    }
    
    func setupLocationManger() {
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation()
    }

    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        businesses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! mainTableViewCell
        let item = businesses[indexPath.row]
        cell.businessNameLabel.text = item.name
        cell.update(displaying: cell.businessImage.urlToImage(imageURL: item.image_url))
        cell.businessRatingLabel.text = utility.businessStar(numberOfStars: Int(item.rating))
        cell.isClosed = item.is_closed
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dVC = storyboard.instantiateViewController(identifier: "BusinessDetailVC") as! BusinessDetailViewController
       
        let item = businesses[indexPath.row]
        dVC.businessImage.urlToImage(imageURL: item.image_url)
        dVC.businessNameLabel.text = item.name
        dVC.updateAddress(address1: item.location.address1, city: item.location.city, state: item.location.state, zipCode: item.location.zip_code)
        dVC.businessDistanceLabel.text = utility.distanceCalculator(item.distance)
        dVC.businessURL = item.url
        dVC.isClosed = item.is_closed
        dVC.businessRatingLabel.text = utility.businessStar(numberOfStars: Int(item.rating))
        
        
        self.navigationController?.pushViewController(dVC, animated: true)
    }
    

}

extension BusinessesTableViewController: YelpDelegate {
    
    func didUpdateBusiness(_ yelpManger: YelpManger, business: [Business]) {
        self.businesses = business
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}

extension BusinessesTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            
            var  titleKey = title?.replacingOccurrences(of: " ", with: "").lowercased()
            titleKey = titleKey?.replacingOccurrences(of: "&", with: "")
            
            print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nhere:",titleKey!)
            
            yelpManger.fetchYelp(lat: lat, long: long, category: "&categories=\(titleKey ?? "")") { (result) in
                DispatchQueue.main.async {
                    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\\n\n\n\\n\n\n\n\n Result: ",result)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
