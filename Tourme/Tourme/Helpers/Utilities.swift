//
//  BusinessesTableViewController.swift
//  Tourme
//
//  Created by Dua Almahyani on 24/12/2020.
//

import Foundation
import UIKit


struct Colors {
    static let blue = UIColor(red: 70.0/255.0, green: 138.0/255.0, blue: 161.0/255.0, alpha: 1)
    static let brightRed = UIColor(red: 222.0/255.0, green: 90.0/255.0, blue: 111.0/255.0, alpha: 1)
    static let lightGreen = UIColor(red: 183/255, green: 215/255, blue: 181/255, alpha: 1)
    static let green = UIColor(red: 43/255, green: 139/255, blue: 111/255, alpha: 1)
}

class Utilities {
    
    func gradentColors(color1: CGColor, color2: CGColor, view: UIView, cornerRadius: CGFloat? = 0) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1,color2]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        gradient.cornerRadius = cornerRadius!

        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func blur(view: UIView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    func distanceCalculator(_ meter: Double) -> String {
        var distance = meter
        if distance >= 1000 {
            distance /= 1000
            return String(format: "%.1f", distance) + "km"
        }
        else {
            return String(format: "%.1f", distance) + "m"
        }
    }
    
    func businessStar(numberOfStars: Int) -> String {
        
        var starRating = String()
        if numberOfStars > 0 {
            for _ in 1...numberOfStars {
                starRating += "★"
            }
            
            if numberOfStars < 5 {
                let unfilledStars = 5 - numberOfStars
                for _ in 1...unfilledStars {
                    starRating += "☆"
                }
            }
        } else {
            for _ in 1...5 {
                starRating += "☆"
            }
        }
        
        return starRating
    }
      
}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func dateFormtted() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self).capitalized
    }
    
}


extension UIImageView {
    
    func urlToImage(imageURL: String) -> UIImage? {
        guard let photoURL = URL(string: imageURL) else { return nil }
        
        URLSession.shared.dataTask(with: photoURL) { (data, responce, error) in
            
            if let error = error {
                print("Data task error. \(error)")
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                return
            }
            
        }.resume()
        
        return self.image
    }
    
    
}

extension UIView {

    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0, paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}


