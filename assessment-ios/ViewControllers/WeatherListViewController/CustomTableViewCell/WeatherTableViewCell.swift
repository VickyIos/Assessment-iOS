//
//  WeatherTableViewCell.swift
//  assessment-ios
//
//  Created by Vignesh on 22/01/21.
//  Copyright © 2021 Vignesh. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var backgroundContainerView: UIView!
    private var weatherStatusImageView: UIImageView!
    private var weatherStatusLabel: UILabel!
    private var countryTitleLabel: UILabel!
    private var temperatureLabel: UILabel!
    
    fileprivate var hasSetupConstraints: Bool = false

    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func loadData(data: List) {

        self.countryTitleLabel.text = data.name.uppercased()
        self.weatherStatusLabel.text = data.weather.first?.main.capitalized
        
        switch data.weather.first?.main.lowercased() {
        case AppConstants.WeatherType.clouds.rawValue:
            self.weatherStatusImageView.image = UIImage(named: "unknown")
        case AppConstants.WeatherType.drizzle.rawValue:
            self.weatherStatusImageView.image = UIImage(named: "drizzle")
        case AppConstants.WeatherType.rain.rawValue:
            self.weatherStatusImageView.image = UIImage(named: "rain")
        case AppConstants.WeatherType.clear.rawValue:
            self.weatherStatusImageView.image = UIImage(named: "normal")
        default:
            self.weatherStatusImageView.image = UIImage(named: "sunny")
        }
        
        let formatter = MeasurementFormatter()
        let measurement = Measurement(value: data.main.temp, unit: UnitTemperature.fahrenheit)
        let temperature = formatter.string(from: measurement)
        self.temperatureLabel.text = temperature
    }
    
    // MARK: - Private methods
    
    // MARK: - UI and Constraints methods
    
    private func setupViews() {

        let backgroundContainerView = UIView()
        backgroundContainerView.translatesAutoresizingMaskIntoConstraints = false
        backgroundContainerView.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        backgroundContainerView.layer.cornerRadius = 10

        let weatherStatusImageView = UIImageView()
        weatherStatusImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherStatusImageView.contentMode = .scaleAspectFit
        weatherStatusImageView.isUserInteractionEnabled = true
        weatherStatusImageView.layer.cornerRadius = 20
        weatherStatusImageView.clipsToBounds = true
        
        let weatherStatusLable = UILabel()
        weatherStatusLable.translatesAutoresizingMaskIntoConstraints = false
        weatherStatusLable.textColor = .black
        weatherStatusLable.textAlignment = .left
        weatherStatusLable.font = UIFont.systemFont(ofSize: 12)
        weatherStatusLable.textAlignment = .left

        let countryTitleLable = UILabel()
        countryTitleLable.translatesAutoresizingMaskIntoConstraints = false
        countryTitleLable.textColor = .black
        countryTitleLable.textAlignment = .left
        countryTitleLable.numberOfLines = 0
        
        let temperatureLable = UILabel()
        temperatureLable.translatesAutoresizingMaskIntoConstraints = false
        temperatureLable.textColor = .black
        temperatureLable.textAlignment = .right

        self.contentView.addSubview(backgroundContainerView)
        backgroundContainerView.addSubview(weatherStatusImageView)
        backgroundContainerView.addSubview(countryTitleLable)
        backgroundContainerView.addSubview(weatherStatusLable)
        backgroundContainerView.addSubview(temperatureLable)

        self.backgroundContainerView = backgroundContainerView
        self.weatherStatusImageView = weatherStatusImageView
        self.countryTitleLabel = countryTitleLable
        self.weatherStatusLabel = weatherStatusLable
        self.temperatureLabel = temperatureLable
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([

            backgroundContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            backgroundContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            backgroundContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            backgroundContainerView.heightAnchor.constraint(equalToConstant: 80),
            backgroundContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),

            weatherStatusImageView.centerYAnchor.constraint(equalTo: backgroundContainerView.centerYAnchor, constant: -10),
            weatherStatusImageView.leftAnchor.constraint(equalTo: backgroundContainerView.leftAnchor, constant: 9),
            weatherStatusImageView.widthAnchor.constraint(equalToConstant: 40),
            weatherStatusImageView.heightAnchor.constraint(equalToConstant: 40),
            
            weatherStatusLabel.topAnchor.constraint(equalTo: weatherStatusImageView.bottomAnchor, constant: 0),
            weatherStatusLabel.leftAnchor.constraint(equalTo: weatherStatusImageView.leftAnchor),
            weatherStatusLabel.rightAnchor.constraint(equalTo: countryTitleLabel.leftAnchor),
            weatherStatusLabel.bottomAnchor.constraint(equalTo: backgroundContainerView.bottomAnchor, constant: -5),

            countryTitleLabel.centerYAnchor.constraint(equalTo: backgroundContainerView.centerYAnchor, constant: 0),
            countryTitleLabel.leftAnchor.constraint(equalTo: weatherStatusImageView.rightAnchor, constant: 20),
            countryTitleLabel.rightAnchor.constraint(equalTo: temperatureLabel.leftAnchor),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: backgroundContainerView.centerYAnchor),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 70),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 40),
            temperatureLabel.rightAnchor.constraint(equalTo: backgroundContainerView.rightAnchor, constant: -20),
        ])
    }
    
    override func updateConstraints() {
        if hasSetupConstraints == false {
            setupConstraints()
            hasSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}


