//
//  mainTableViewCell.swift
//  Tourme
//
//  Created by Dua Almahyani on 21/12/2020.
//

import UIKit

class mainTableViewCell: UITableViewCell {
    
    let businessImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 84, height: 66))
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 9
        return image
    }()
    
    let imagesSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        return spinner
    }()
    
    let weatherImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "cloud")
        image.tintColor = .white
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowRadius = 7
        image.layer.shadowOpacity = 0.3
        image.layer.shadowOffset = CGSize(width: 0, height: 5)
        return image
    }()
    
    let businessNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Kindom Centre"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let businessCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Local Flavor"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()

    let businessCurrntStateLabel: UILabel = {
        let label = UILabel()
        label.text = "open"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 4/255, green: 168/255, blue: 1/255, alpha: 1)
        return label
    }()
    
    let starImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "smallStar")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    
    let unfilledStarImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "UnfilledStar")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    
    var numberOfStars = 5

    lazy var starsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 1
        
        starImage.anchor(width: 5, height: 5)
        stack.addArrangedSubview(starImage)
        stack.addArrangedSubview(starImage)
        stack.addArrangedSubview(starImage)
        stack.addArrangedSubview(starImage)
        stack.addArrangedSubview(starImage)
        
        return stack
    }()
    
    lazy var statusStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        
        stack.addArrangedSubview(businessCurrntStateLabel)
        stack.addArrangedSubview(starsStackView)
        
        return stack
    }()
    
    lazy var InfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        
        
        stack.addArrangedSubview(businessNameLabel)
        stack.addArrangedSubview(businessCategoryLabel)
        stack.addArrangedSubview(statusStackView)
        
        
        
        return stack
    }()
    
    lazy var backgroundColorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 9
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.07)
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        
        
        return view
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        addSubview(businessImage)
        businessImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 15, width: 84, height: 66)
        
        addSubview(imagesSpinner)
        imagesSpinner.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 15, width: 84, height: 66)
        
        addSubview(backgroundColorView)
        backgroundColorView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 18, paddingLeft: 20, paddingBottom: 18, paddingRight: 20)
        
        addSubview(InfoStackView)
        InfoStackView.anchor(top: topAnchor, left: businessImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 25, paddingLeft: 10, paddingBottom: 25, paddingRight: 20)
        
        addSubview(weatherImage)
        weatherImage.centerYAnchor.constraint(equalTo: backgroundColorView.centerYAnchor).isActive = true
        weatherImage.anchor(right: rightAnchor,
                            paddingRight: 30,
                            width: 30, height: 30)
        
        
    }
    
    func update(displaying image: UIImage?) {
        if let imageToDisplay = image {
            imagesSpinner.stopAnimating()
            businessImage.image = imageToDisplay
        } else {
            imagesSpinner.startAnimating()
            businessImage.image = nil
        }
    }

    func businessStar(numberOfStars: Int) {
        
        for _ in 1...numberOfStars {
            let image = UIImageView()
            image.image = #imageLiteral(resourceName: "Star")
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            image.layer.borderColor = UIColor.white.cgColor
            starsStackView.addArrangedSubview(image)
        }
        
//       if numberOfStars < 5 {
//            let unfilledStars = 5 - numberOfStars
//            for _ in 1...unfilledStars {
//                let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
//                 image.image = #imageLiteral(resourceName: "UnfilledStar")
//                image.contentMode = .scaleAspectFill
//                image.clipsToBounds = true
//                image.layer.borderColor = UIColor.white.cgColor
//                starsStackView.addArrangedSubview(image)
//            }
//        }
    }
    
    func updateImage(imageURL: String) {
        
        guard let photoURL = URL(string: imageURL) else {
            self.businessImage.image = UIImage(named: "gray")
            return
        }
        
        // clear photo first
        self.businessImage.image = nil
        
        fetchImageData(from: photoURL)
    }
    
    private func fetchImageData(from url: URL) {
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            
            if let error = error {
                print("Data task error. \(error)")
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.businessImage.image = image
                }
            }
            
        }.resume()
    }
    
}
