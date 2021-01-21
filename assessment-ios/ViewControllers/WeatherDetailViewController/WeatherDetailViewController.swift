//
//  WeatherDetailViewController.swift
//  assessment-ios
//
//  Created by Vignesh on 22/01/21.
//  Copyright © 2021 Vignesh. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    // MARK: - Properties
    
    private var backgroundContainerView: UIView!
    private var weatherStatusImageView: UIImageView!
    private var weatherStatusLabel: UILabel!
    private var countryTitleLabel: UILabel!
    private var minTemperatureLabel: UILabel!
    private var maxTemperatureLabel: UILabel!
    var selectedData: List!

    // MARK: - Lifecycle
    
    // Custom initializers go here

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        loadData(data: selectedData)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - User Interactions
    
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
        let minMeasurement = Measurement(value: data.main.tempMin, unit: UnitTemperature.fahrenheit)
        let minTemperature = formatter.string(from: minMeasurement)
        self.minTemperatureLabel.text = String(format: "Min: %@", minTemperature)
        
        let maxMeasurement = Measurement(value: data.main.tempMax, unit: UnitTemperature.fahrenheit)
        let maxTemperature = formatter.string(from: maxMeasurement)
        self.maxTemperatureLabel.text = String(format: "Max: %@", maxTemperature)
    }
    
    // MARK: - Private methods
    
    // MARK: - UI and Constraints methods

    private func setupViews() {
        view.backgroundColor = .white

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
        weatherStatusLable.font = UIFont.systemFont(ofSize: 12)
        weatherStatusLable.textAlignment = .center

        let countryTitleLable = UILabel()
        countryTitleLable.translatesAutoresizingMaskIntoConstraints = false
        countryTitleLable.textColor = .black
        countryTitleLable.textAlignment = .center
        weatherStatusLable.font = UIFont.systemFont(ofSize: 20)
        countryTitleLable.numberOfLines = 0
        
        let minTemperatureLable = UILabel()
        minTemperatureLable.translatesAutoresizingMaskIntoConstraints = false
        minTemperatureLable.textColor = .black
        minTemperatureLable.textAlignment = .left
        
        let maxTemperatureLable = UILabel()
        maxTemperatureLable.translatesAutoresizingMaskIntoConstraints = false
        maxTemperatureLable.textColor = .black
        maxTemperatureLable.textAlignment = .right

        self.view.addSubview(backgroundContainerView)
        backgroundContainerView.addSubview(weatherStatusImageView)
        backgroundContainerView.addSubview(countryTitleLable)
        backgroundContainerView.addSubview(weatherStatusLable)
        backgroundContainerView.addSubview(minTemperatureLable)
        backgroundContainerView.addSubview(maxTemperatureLable)

        self.backgroundContainerView = backgroundContainerView
        self.weatherStatusImageView = weatherStatusImageView
        self.countryTitleLabel = countryTitleLable
        self.weatherStatusLabel = weatherStatusLable
        self.minTemperatureLabel = minTemperatureLable
        self.maxTemperatureLabel = maxTemperatureLable
        
        setupConstraints()
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([

            backgroundContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            backgroundContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            backgroundContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            backgroundContainerView.heightAnchor.constraint(equalToConstant: 300),

            weatherStatusImageView.centerXAnchor.constraint(equalTo: backgroundContainerView.centerXAnchor, constant: 0),
            weatherStatusImageView.topAnchor.constraint(equalTo: backgroundContainerView.topAnchor, constant: 20),
            weatherStatusImageView.widthAnchor.constraint(equalToConstant: 50),
            weatherStatusImageView.heightAnchor.constraint(equalToConstant: 50),
            
            weatherStatusLabel.topAnchor.constraint(equalTo: weatherStatusImageView.bottomAnchor, constant: 0),
            weatherStatusLabel.leftAnchor.constraint(equalTo: backgroundContainerView.leftAnchor, constant: 10),
            weatherStatusLabel.rightAnchor.constraint(equalTo: backgroundContainerView.rightAnchor, constant: -10),

            countryTitleLabel.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor, constant: 50),
            countryTitleLabel.centerXAnchor.constraint(equalTo: backgroundContainerView.centerXAnchor, constant: 0),
            countryTitleLabel.leftAnchor.constraint(equalTo: backgroundContainerView.leftAnchor, constant: 20),
            countryTitleLabel.rightAnchor.constraint(equalTo: backgroundContainerView.rightAnchor, constant: -20),
            
            minTemperatureLabel.topAnchor.constraint(equalTo: countryTitleLabel.bottomAnchor, constant: 50),
            minTemperatureLabel.leftAnchor.constraint(equalTo: backgroundContainerView.leftAnchor, constant: 20),
            minTemperatureLabel.widthAnchor.constraint(equalToConstant: 100),
            minTemperatureLabel.heightAnchor.constraint(equalToConstant: 40),
            
            maxTemperatureLabel.topAnchor.constraint(equalTo: countryTitleLabel.bottomAnchor, constant: 50),
            maxTemperatureLabel.rightAnchor.constraint(equalTo: backgroundContainerView.rightAnchor, constant: -20),
            maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 100),
            maxTemperatureLabel.heightAnchor.constraint(equalToConstant: 40),
            
            backgroundContainerView.bottomAnchor.constraint(equalTo: maxTemperatureLabel.bottomAnchor, constant: 50),
        ])
    }
}


