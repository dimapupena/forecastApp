//
//  ForecastViewController.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 01.08.2022.
//

import Foundation
import UIKit
import MapKit

class ForecastViewController: UIViewController {
    
    private var viewModel: ForecastViewModel
    static private let forecastCellIdentifier = "ForecastTableCell"
    
    private var weatherImageView: UIImageView!
    private var cityName: UILabel!
    private var descriptionLabel: UILabel!
    private var dateLabel: UILabel!
    private var maxTempLabel: UILabel!
    private var minTempLabel: UILabel!
    private var showLocationImage: UIImageView!
    private var forecastTableView: UITableView!
    
    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .mainColor
        
        setupViews()
        
        showLoader()
        viewModel.loadForecast { [weak self] in
            DispatchQueue.main.async {
                self?.hideLoader()
                self?.updateView()
            }
        }
    }
    
    func updateView() {
        forecastTableView.reloadData()
    }
    
    private func setupViews() {
        setupWeatherImageView()
        setupCityName()
        setupDescriptionLabel()
        setupDateLabel()
        setupTemperatureLabels()
        setupShowLocationImage()
        setupTableView()
    }
    
    private func setupWeatherImageView() {
        weatherImageView = UIImageView()
        weatherImageView.layer.cornerRadius = 10
        weatherImageView.image = viewModel.weatherData.currentWeatherImage
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(weatherImageView)
        weatherImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        weatherImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func setupCityName() {
        cityName = UILabel()
        cityName.textAlignment = .left
        cityName.text = viewModel.weatherData.location.placeName
        cityName.font = UIFont.boldSystemFont(ofSize: 18)
        cityName.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cityName)
        cityName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        cityName.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 20).isActive = true
        cityName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = viewModel.weatherData.currentWeather?.weather.first?.main ?? ""
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 20).isActive = true
    }
    
    private func setupDateLabel() {
        dateLabel = UILabel()
        dateLabel.textAlignment = .center
        if let dataUnix = viewModel.weatherData.currentWeather?.dt {
            let date = Date(timeIntervalSince1970: TimeInterval(dataUnix))
            dateLabel.text = date.toString(format: "dd MMMM")
        }
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 20).isActive = true
    }
    
    private func setupTemperatureLabels() {
        minTempLabel = UILabel()
        minTempLabel.textAlignment = .center
        minTempLabel.text = "min: \(viewModel.weatherData.currentWeather?.main?.tempMin ?? 10)"
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(minTempLabel)
        minTempLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        minTempLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        maxTempLabel = UILabel()
        maxTempLabel.textAlignment = .center
        maxTempLabel.text = "max: \(viewModel.weatherData.currentWeather?.main?.tempMax ?? 10)"
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(maxTempLabel)
        maxTempLabel.topAnchor.constraint(equalTo: minTempLabel.bottomAnchor, constant: 5).isActive = true
        maxTempLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupShowLocationImage() {
        showLocationImage = UIImageView()
        showLocationImage.image = UIImage(named: "showLocation")
        showLocationImage.isUserInteractionEnabled = true
        showLocationImage.translatesAutoresizingMaskIntoConstraints = false
        showLocationImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openMapForPlace)))
        view.addSubview(showLocationImage)
        
        showLocationImage.topAnchor.constraint(equalTo: maxTempLabel.bottomAnchor, constant: 10).isActive = true
        showLocationImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        showLocationImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        showLocationImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupTableView() {
        forecastTableView = UITableView()
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        forecastTableView.backgroundColor = .clear
        forecastTableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: Self.forecastCellIdentifier)
        forecastTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(forecastTableView)
        forecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        forecastTableView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
        forecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        forecastTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc private func openMapForPlace() {
        let locationConfiguration = viewModel.getLocationMapConfiguration()
        if let placemark = locationConfiguration.0, let options = locationConfiguration.1 {
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = viewModel.weatherData.location.placeName
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherData.forecase?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.forecastCellIdentifier, for: indexPath) as! ForecastTableViewCell
        if let weather = viewModel.weatherData.forecase?.list?[indexPath.row] {
            cell.updateView(locationWeather: viewModel.weatherData, forecastWeather: weather)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
