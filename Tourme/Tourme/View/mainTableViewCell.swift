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
    
    let businessRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "Local Flavor"
        label.font = UIFont.systemFont(ofSize: 7)
        return label
    }()

    let businessCurrntStateLabel: UILabel = {
        let label = UILabel()
        label.text = "open"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 4/255, green: 168/255, blue: 1/255, alpha: 1)
        return label
    }()
    

    var isClosed: Bool = false {
        didSet {
            if isClosed {
                businessCurrntStateLabel.text = "Out Of Buisness"
                businessCurrntStateLabel.textColor =  UIColor.red
            } else {
                businessCurrntStateLabel.text = "In Buisness"
            }
        }
    }
    
    lazy var statusStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        
        stack.addArrangedSubview(businessCurrntStateLabel)
        
        return stack
    }()
    
    lazy var InfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        
        
        stack.addArrangedSubview(businessNameLabel)
        stack.addArrangedSubview(businessRatingLabel)
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
    
}
