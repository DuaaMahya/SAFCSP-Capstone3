//
//  BusinessDetailViewController.swift
//  Tourme
//
//  Created by Dua Almahyani on 23/12/2020.
//

import UIKit
import Charts

class BusinessDetailViewController: UIViewController, ChartViewDelegate, WeatherDelegate {
    
    let utility = Utilities()
    var weatherManger = WeatherManger()
    var businessLat = Double()
    var businessLong = Double()
    
    let businessImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "a42g7clq33q51")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 9
        return image
    }()
    
    
    let businessNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Outer Richmond"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    let businessDistanceLabel: UILabel = {
        let label = UILabel()
        label.text = "3km"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let businessAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "3519 Balboa St, San Francisco, CA 94121"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    let businessCurrntStateLabel: UILabel = {
        let label = UILabel()
        label.text = "open"
        label.textColor = UIColor(red: 4/255, green: 168/255, blue: 1/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let businessRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "★"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    
    let overviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Overview", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.setTitleColor(.darkGray, for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let photosButton: UIButton = {
        let button = UIButton()
        button.setTitle("Photos", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.setTitleColor(.darkGray, for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let aboutButton: UIButton = {
        let button = UIButton()
        button.setTitle("About", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.setTitleColor(.darkGray, for: .normal)
        button.tag = 3
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var firstRowStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 5
        
        stack.addArrangedSubview(businessNameLabel)
        stack.addArrangedSubview(businessDistanceLabel)
        
        return stack
    }()
    
    lazy var firstColumnStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        
        stack.addArrangedSubview(firstRowStackView)
        stack.addArrangedSubview(businessRatingLabel)
        
        return stack
    }()
    
    lazy var secondColumnStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        
        stack.addArrangedSubview(businessAddressLabel)
        stack.addArrangedSubview(businessCurrntStateLabel)
        
        return stack
    }()
    
    lazy var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        stack.addArrangedSubview(firstColumnStackView)
        stack.addArrangedSubview(secondColumnStackView)
        
        return stack
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalCentering
        
        stack.addArrangedSubview(overviewButton)
        stack.addArrangedSubview(photosButton)
        stack.addArrangedSubview(aboutButton)
        
        let line = CAShapeLayer()
        line.strokeColor = UIColor.lightGray.cgColor
        
        let size = CGSize(width: view.frame.size.width - 35, height: 0)
        
        let path = CGMutablePath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        
        line.path = path
        line.position = CGPoint(x: 0, y: stack.bounds.minY + 30)
        line.lineWidth = 1
        stack.layer.addSublayer(line)
        
        return stack
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
    
    //MARK: - Overview
    
    var businessURL = String()
    
    let websiteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "WebIcon"), for: .normal)
        button.addTarget(self, action: #selector(websiteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let callButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "CallIcon"), for: .normal)
        button.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let businessCurrentTempLabel: UILabel = {
        let label = UILabel()
        label.text = "17C"
        label.font = UIFont.systemFont(ofSize: 28)
        label.textColor = UIColor(red: 4/255, green: 168/255, blue: 1/255, alpha: 1)
        return label
    }()
    
    lazy var businessContactStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        
        stack.addArrangedSubview(websiteButton)
        stack.addArrangedSubview(callButton)
        
        
        return stack
    }()
    
    lazy var overviewContentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        
        stack.addArrangedSubview(businessContactStackView)
        stack.addArrangedSubview(businessCurrentTempLabel)
        stack.addArrangedSubview(lineChartView)
        lineChartView.anchor(height: view.frame.width * 0.7)
        setData()
        return stack
    }()
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.rightAxis.enabled = false
        
        
        let yAxis = chartView.leftAxis
        //yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelPosition = .outsideChart
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.setLabelCount(7, force: false)
        
        chartView.animate(xAxisDuration: 2)
        return chartView
    }()
    
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 16),
        ChartDataEntry(x: 1.0, y: 16),
        ChartDataEntry(x: 2.0, y: 15.6),
        ChartDataEntry(x: 3.0, y: 14.7),
        ChartDataEntry(x: 4.0, y: 14.7),
        ChartDataEntry(x: 5.0, y: 14.4),
        ChartDataEntry(x: 6.0, y: 14.2),
        ChartDataEntry(x: 7.0, y: 14.0),
        ChartDataEntry(x: 8.0, y: 13.7),
        ChartDataEntry(x: 9.0, y: 13.4),
        ChartDataEntry(x: 10.0, y: 12.1),
        ChartDataEntry(x: 11.0, y: 12.3),
        ChartDataEntry(x: 12.0, y: 12.5),
        ChartDataEntry(x: 13.0, y: 12.6),
        ChartDataEntry(x: 14.0, y: 12.8),
        ChartDataEntry(x: 15.0, y: 12.0),
        ChartDataEntry(x: 16.0, y: 11.2),
        ChartDataEntry(x: 17.0, y: 10.3),
        ChartDataEntry(x: 18.0, y: 10.2),
        ChartDataEntry(x: 19.0, y: 10),
        ChartDataEntry(x: 20.0, y: 9.8),
        ChartDataEntry(x: 21.0, y: 9.8),
        ChartDataEntry(x: 22.0, y: 9.7),
        ChartDataEntry(x: 23.0, y: 9.4),
        
    ]
    
    
    //MARK: - Photos Collection
    
    var collectionView: UICollectionView?
    
    let gallery: [UIImage] = [#imageLiteral(resourceName: "a42g7clq33q51"), #imageLiteral(resourceName: "4a1af8a692f40b7836dc1ea20bb71937"), #imageLiteral(resourceName: "tumblr_ntnseeIUwt1r09wbpo1_540"), #imageLiteral(resourceName: "a42g7clq33q51"), #imageLiteral(resourceName: "4a1af8a692f40b7836dc1ea20bb71937"), #imageLiteral(resourceName: "tumblr_ntnseeIUwt1r09wbpo1_540"), #imageLiteral(resourceName: "a42g7clq33q51"), #imageLiteral(resourceName: "4a1af8a692f40b7836dc1ea20bb71937"), #imageLiteral(resourceName: "tumblr_ntnseeIUwt1r09wbpo1_540"), #imageLiteral(resourceName: "a42g7clq33q51"), #imageLiteral(resourceName: "4a1af8a692f40b7836dc1ea20bb71937"), #imageLiteral(resourceName: "tumblr_ntnseeIUwt1r09wbpo1_540"), #imageLiteral(resourceName: "a42g7clq33q51"), #imageLiteral(resourceName: "4a1af8a692f40b7836dc1ea20bb71937"), #imageLiteral(resourceName: "tumblr_ntnseeIUwt1r09wbpo1_540")]
    
    
    //MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        view.addSubview(businessImage)
        businessImage.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 250)
        
        view.addSubview(infoStackView)
        infoStackView.anchor(top: businessImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(buttonsStackView)
        buttonsStackView.anchor(top: infoStackView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)
        
        weatherManger.delegate = self
        weatherManger.fetchWeather(lat: businessLat, long: businessLong) { (result) in
            print(result)
        }
        
    }
    
    
    //MARK: - Functions
    
    func setupOverviewContent() {
        overviewContentStackView.isHidden = false
        collectionView?.isHidden = true
        collectionView?.alpha = 0
        view.addSubview(overviewContentStackView)
        overviewContentStackView.anchor(top: buttonsStackView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 20, paddingRight: 20)
        
        
       
    }
    
    func setupCollectionView() {
        collectionView?.isHidden = false
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
        collectionView.register(BusinessDetailGalleryCell.self, forCellWithReuseIdentifier: "GalleryCell")
        
        view.addSubview(collectionView)
        collectionView.anchor(top: buttonsStackView.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: view.bottomAnchor,
                              right: view.rightAnchor,
                              paddingTop: 20,
                              paddingLeft: 20,
                              paddingRight: 20)
    }
    
    func updateAddress(address1: String?, city: String?, state: String?, zipCode: String?) {
        businessAddressLabel.text = "\(address1 ?? ""), \(city ?? ""), \(state ?? "") \(zipCode ?? "")"
    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: yValues, label: "Temperture")
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 2
        set1.setColor(Colors.green)
        set1.fill = Fill(color: Colors.lightGreen)
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.drawVerticalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    func didUpdateWeather(_ weatherManger: WeatherManger, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.businessCurrentTempLabel.text = "\(weather.temperatureString)°C"
        }
    }
    
    func updateChart() {
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    
    
   
    
    //MARK: - @objc Selectors
    
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            print("overview")
            overviewButton.setTitleColor(Colors.green, for: .normal)
            photosButton.setTitleColor(.darkGray, for: .normal)
            aboutButton.setTitleColor(.darkGray, for: .normal)
            
            setupOverviewContent()
            collectionView?.isHidden = true
            
        case 2:
            print("photos")
            overviewButton.setTitleColor(.darkGray, for: .normal)
            photosButton.setTitleColor(Colors.green, for: .normal)
            aboutButton.setTitleColor(.darkGray, for: .normal)
            
            overviewContentStackView.isHidden = true
            setupCollectionView()
            
            
        case 3:
            print("about")
            overviewButton.setTitleColor(.darkGray, for: .normal)
            photosButton.setTitleColor(.darkGray, for: .normal)
            aboutButton.setTitleColor(Colors.green, for: .normal)
            
            overviewContentStackView.isHidden = true
            collectionView?.isHidden = true
            
        default:
            print("error while choosing")
        }
    }
    
    @objc func websiteButtonTapped() {
        if let url = URL(string: businessURL) {
            UIApplication.shared.open(url)
        } else {
            print("empty url")
        }
    }
    
    @objc func callButtonTapped() {
        
    }
    

    

}

extension BusinessDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { gallery.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! BusinessDetailGalleryCell
        cell.image = gallery[indexPath.row]
        return cell
    }
    
    
}

extension BusinessDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 42) / 3
        return CGSize(width: width, height: width)
    }
    
}
