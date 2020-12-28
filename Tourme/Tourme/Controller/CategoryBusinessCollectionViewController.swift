//
//  CategoryBusinessCollectionViewController.swift
//  Tourme
//
//  Created by Dua Almahyani on 24/12/2020.
//

import UIKit

private let reuseIdentifier = "CategoryCell"

class CategoryBusinessCollectionViewController: UIViewController {
    
    var collectionView: UICollectionView?
    
    let images: [UIImage] = [#imageLiteral(resourceName: "ResturantIcon"), #imageLiteral(resourceName: "RealEstateIcon"), #imageLiteral(resourceName: "HomeServiceIcon"), #imageLiteral(resourceName: "EducationIcon"), #imageLiteral(resourceName: "PetsIcon"), #imageLiteral(resourceName: "ArtIcon"), #imageLiteral(resourceName: "EventPlaningIcon"), #imageLiteral(resourceName: "ReligiousOrgnizationIcon"), #imageLiteral(resourceName: "LocalFlavorIcon"), #imageLiteral(resourceName: "MassMediaIcon"), #imageLiteral(resourceName: "Hotels&TravelIcon"), #imageLiteral(resourceName: "Health&MedicalIcon")]
    let categories = ["Restaurants", "Real Estate", "Home Service", "Education", "Pets", "Galleries","Event Planning", "Churches", "Yelp Events", "Mass Media", "Hotels & Travel" ,"health"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupCollectionView()

    }


    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .clear
        collectionView?.showsVerticalScrollIndicator = false
        
        guard let collectionView = collectionView else {
            print("collection found nil")
            return
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainPageCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor,
                              left: view.leftAnchor,
                              bottom: view.bottomAnchor,
                              right: view.rightAnchor,
                              paddingLeft: 10,
                              paddingRight: 10)
    }

    
}

extension CategoryBusinessCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainPageCategoriesCollectionViewCell
    
        cell.categoryImage.image = images[indexPath.row]
        cell.categoryNameLabel.font = UIFont.boldSystemFont(ofSize: 13)
        cell.categoryNameLabel.text = categories[indexPath.row]
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dVC = storyboard.instantiateViewController(identifier: "CategoryBusinessVC") as! BusinessesTableViewController
       
        dVC.title = categories[indexPath.row]
        
        self.navigationController?.pushViewController(dVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 60) / 3
        let height = width * 1.1
        return CGSize(width: width, height: height)
    }
}
