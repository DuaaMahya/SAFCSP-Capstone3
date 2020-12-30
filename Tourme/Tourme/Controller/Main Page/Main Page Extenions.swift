//
//  Main Page Extenions.swift
//  Tourme
//
//  Created by Dua Almahyani on 30/12/2020.
//

import UIKit
import CoreLocation

extension MainPageViewController: WeatherDelegate {
    
    func didUpdateWeather(_ weatherManger: WeatherManger, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempertureLabel.text = "\(weather.temperatureString)°C"
            self.cityLabel.text = weather.cityName
            self.weatherConditionImage.image = UIImage(named: weather.conditionName)
        }
    }
    
}

extension MainPageViewController: YelpDelegate {
    
    func didUpdateBusiness(_ yelpManger: YelpManger, business: YelpData) {
        
        DispatchQueue.main.async {
            self.businesses = Array(business.businesses)
            for i in self.businesses {
                let bool = RealmManager().saveBusiness(i)
            }
            print("Connected")
            self.tableView.reloadData()
        }
    }
}


extension MainPageViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            
            weatherManger.fetchWeather(lat: lat, long: long) { (result) in
                print(result)
            }
            
            if Reachability.isConnectedToNetwork(){
                yelpManger.fetchYelp(lat: lat, long: long) { (result) in
                    DispatchQueue.main.async {
                        print(result)
                        self.tableView.reloadData()
                    }
                }
                print("Connected")
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MainPageViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        weatherManger.fetchWeather(city: searchBar.text) { (result) in
            print(result)
        }
        
        searchBar.endEditing(true)
        searchBar.resignFirstResponder()
    }
   
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 40 }
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        //view.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 0.3)
        
        utility.blur(view: view)
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width-15, height: 40))
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Businesses near me"
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! mainTableViewCell
        let item = businesses[indexPath.row]
        cell.businessNameLabel.text = item.name
        cell.update(displaying: cell.businessImage.urlToImage(imageURL: item.image_url))
        cell.businessRatingLabel.text = utility.businessStar(numberOfStars: Int(item.rating))
        cell.isClosed = item.is_closed
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dVC = storyboard.instantiateViewController(identifier: "BusinessDetailVC") as! BusinessDetailViewController
        let item = businesses[indexPath.row]
        dVC.businessImage.urlToImage(imageURL: item.image_url)
        dVC.businessNameLabel.text = item.name
        dVC.updateAddress(address1: item.location!.address1, city: item.location!.city, state: item.location!.state, zipCode: item.location!.zip_code)
        dVC.businessDistanceLabel.text = utility.distanceCalculator(item.distance)
        dVC.businessURL = item.url
        dVC.isClosed = item.is_closed
        dVC.businessRatingLabel.text = utility.businessStar(numberOfStars: Int(item.rating))
        dVC.businessLat = item.coordinates!.latitude
        dVC.businessLong = item.coordinates!.longitude
        dVC.businessPhoneNumber = item.phone
        self.navigationController?.pushViewController(dVC, animated: true)
    }
    
}

extension MainPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath) as! MainPageCategoriesCollectionViewCell
        let itemImage = images[indexPath.row]
        let itemLabel = categories[indexPath.row]
        cell.categoryImage.image = itemImage
        cell.categoryNameLabel.text = itemLabel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        if indexPath.row == images.count - 1 {
            let cVC = storyboard.instantiateViewController(identifier: "CategoriesBusinessVC") as! CategoryBusinessCollectionViewController
            
            self.navigationController?.pushViewController(cVC, animated: true)
        } else {
            let dVC = storyboard.instantiateViewController(identifier: "CategoryBusinessVC") as! BusinessesTableViewController
            dVC.title = categories[indexPath.row]
            self.navigationController?.pushViewController(dVC, animated: true)
        }
    }
    
}

extension MainPageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 63, height: 85)
    }
}
