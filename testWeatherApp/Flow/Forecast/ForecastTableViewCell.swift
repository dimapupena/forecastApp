//
//  ForecastTableViewCell.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 01.08.2022.
//

import Foundation
import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    private var weatherImageView: UIImageView!
    private var cityName: UILabel!
    private var descriptionLabel: UILabel!
    private var dateLabel: UILabel!
    private var maxTempLabel: UILabel!
    private var minTempLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(locationWeather: LocationWeatherData?, forecastWeather: ForecastWeather) {
        guard let locationWeather = locationWeather else { return }
        weatherImageView.image = forecastWeather.image
        cityName.text = locationWeather.location.placeName
        descriptionLabel.text = forecastWeather.forecast?.weather?.first?.main ?? ""
        minTempLabel.text = "min: \(forecastWeather.forecast?.main?.tempMin ?? 10)"
        maxTempLabel.text = "max: \(forecastWeather.forecast?.main?.tempMax ?? 10)"
        if let dataUnix = forecastWeather.forecast?.dt {
            let date = Date(timeIntervalSince1970: TimeInterval(dataUnix))
            dateLabel.text = date.toString(format: "HH:mm dd MMMM")
        }
    }
    
    private func setupViews() {
        setupWeatherImageView()
        setupCityName()
        setupDescriptionLabel()
        setupDateLabel()
        temperatureLabels()
    }
    
    private func setupWeatherImageView() {
        weatherImageView = UIImageView()
        weatherImageView.layer.cornerRadius = 10
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(weatherImageView)
        weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        weatherImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupCityName() {
        cityName = UILabel()
        cityName.textAlignment = .left
        cityName.font = UIFont.boldSystemFont(ofSize: 18)
        cityName.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cityName)
        cityName.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        cityName.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 10).isActive = true
        cityName.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 10).isActive = true
    }
    
    private func setupDateLabel() {
        dateLabel = UILabel()
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 10).isActive = true
    }
    
    private func temperatureLabels() {
        minTempLabel = UILabel()
        minTempLabel.textAlignment = .center
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(minTempLabel)
        minTempLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        minTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        maxTempLabel = UILabel()
        maxTempLabel.textAlignment = .center
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(maxTempLabel)
        maxTempLabel.topAnchor.constraint(equalTo: minTempLabel.bottomAnchor, constant: 5).isActive = true
        maxTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
}

