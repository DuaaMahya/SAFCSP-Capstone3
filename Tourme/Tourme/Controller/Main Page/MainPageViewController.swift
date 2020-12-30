//
//  ViewController.swift
//  Tourme
//
//  Created by Dua Almahyani on 21/12/2020.
//

import UIKit
import CoreLocation
import RealmSwift

class MainPageViewController: UIViewController {
    
    let tableCell = "businessesCell"
    let collectionCell = "categoriesCell"
    
    var businesses = [Business]()
    
    var searchBar = UISearchBar()
    var tableView = UITableView()
    var collectionView: UICollectionView?
    
    let utility = Utilities()
    
    let images: [UIImage] = [#imageLiteral(resourceName: "ResturantIcon"), #imageLiteral(resourceName: "RealEstateIcon"), #imageLiteral(resourceName: "HomeServiceIcon"), #imageLiteral(resourceName: "EducationIcon"), #imageLiteral(resourceName: "PetsIcon"), #imageLiteral(resourceName: "ArtIcon"), #imageLiteral(resourceName: "EventPlaningIcon"), #imageLiteral(resourceName: "more+")]
    let categories = ["Restaurants", "Real Estate", "Home Service", "Education", "Pets", "Galleries", "Event Planning", " "]
    
    var weatherManger = WeatherManger()
    var yelpManger = YelpManger()
    
    let locationManger = CLLocationManager()
    
 
    lazy var header: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width + 40))
        
        
        view.addSubview(cityLabel)
        cityLabel.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         paddingTop: 20,
                         paddingLeft: 20,
                         paddingBottom: 20)
        
        view.addSubview(containerView)
        containerView.anchor(top: cityLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 227)
        
        
        view.addSubview(containerButton)
        containerButton.anchor(top: cityLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 227)
        
        
        return view
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "City"
        label.font = UIFont.boldSystemFont(ofSize: 33)
        return label
    }()
    
    lazy var containerButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 40, height: 227))
        button.addTarget(self, action: #selector(weatherViewTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 40, height: 227))
        view.layer.cornerRadius = 9
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        
        view.addSubview(weatherConditionImage)
        weatherConditionImage.anchor(top: view.topAnchor,
                                     right: view.rightAnchor,
                                     paddingTop: 18,
                                     paddingRight: 8,
                                     width: 80,
                                     height: 80)
        
        view.addSubview(weatherImage)
        weatherImage.anchor(bottom: view.bottomAnchor,
                            right: view.rightAnchor,
                            paddingBottom: 8,
                            paddingRight: 40,
                            width: 124,
                            height: 124)
        
        view.addSubview(weatherStackView)
        weatherStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        weatherStackView.anchor(left: view.leftAnchor, paddingLeft: 32, width: 110, height: 154)
        
        return view
    }()
    
    lazy var dayStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = -14
        stack.layer.cornerRadius = 9.0
        
        stack.addArrangedSubview(dayLabel)
        stack.addArrangedSubview(dateLabel)
        
        
        return stack
    }()
    
    lazy var weatherStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.layer.cornerRadius = 9.0
        stack.backgroundColor = UIColor(named: "Color")
        
        stack.addArrangedSubview(tempertureLabel)
        stack.addArrangedSubview(dayStackView)
        
        return stack
    }()
    
    let weatherConditionImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "sun")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let weatherImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Saly-22")
        return image
    }()
    
    var tempertureLabel: UILabel = {
        var label = UILabel()
        label.text = "3C"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    var dayLabel: UILabel = {
        var label = UILabel()
        var date = Date()
        label.text = "\(date.dayOfWeek()!)"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var dateLabel: UILabel = {
        var label = UILabel()
        var date = Date()
        label.text = "\(date.dateFormtted()!)"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    
    
    //MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManger.delegate = self
        yelpManger.delegate = self
        
        utility.gradentColors(color1: Colors.lightGreen.cgColor, color2: Colors.green.cgColor, view: containerView, cornerRadius: 9)
        
        setupSearchBar()
        setupTableView()
        setupCollectionView()
        setupLocationManger()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
       if  Reachability.isConnectedToNetwork() == false {
            self.businesses = Array(RealmManager().getAllBusinesses()!)
            print("Disconnected")
            print(self.businesses)
        }
    }
    
    
    //MARK: - Functions
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        
       // utility.blur(view: searchBar.backgroundColor.cgColor)
        self.view.addSubview(searchBar)
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 20,
                         paddingLeft: 20,
                         paddingRight: 20)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = header
        self.view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: "BGColor")
        tableView.separatorColor = .clear
        tableView.rowHeight = 90
        tableView.register(mainTableViewCell.self, forCellReuseIdentifier: tableCell)
        tableView.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor,
                         bottom: view.bottomAnchor, right: view.rightAnchor,
                         paddingTop: 10, paddingLeft: 0,
                         paddingBottom: 0, paddingRight: 0)
        tableView.reloadData()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset.left = 20
        layout.sectionInset.right = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .clear
        collectionView?.showsHorizontalScrollIndicator = false
        
        guard let collectionView = collectionView else { return }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
        collectionView.register(MainPageCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: collectionCell)
        
        header.addSubview(collectionView)
        
        collectionView.anchor(top: containerView.bottomAnchor,
                              left: header.leftAnchor,
                              bottom: header.bottomAnchor,
                              right: header.rightAnchor, paddingTop: 8)
    }
    
    func setupLocationManger() {
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation()
    }
    
    //MARK: - @objc Selectors
    
    @objc func weatherViewTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "weatherVC", sender: nil)
    }
    
}

