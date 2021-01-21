//
//  WeatherListViewController.swift
//  assessment-ios
//
//  Created by Vignesh on 22/01/21.
//  Copyright © 2021 Vignesh. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController {

    // MARK: - Properties
    private var activityIndicator: UIActivityIndicatorView!
    private var tableView: UITableView!
    private var weatherListData = [List]()
    
    // MARK: - Lifecycle
    
    // Custom initializers go here

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        fetchWeatherList()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - User Interactions
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    
    func fetchWeatherList() {
        NetworkingService.shared.fetchWeatherList { (response, error) in
            self.activityIndicator.stopAnimating()
            guard let weatherList = response else {
                self.showAlert(title: "Weather", message: "error while fetching weather list")
                return
            }
            self.weatherListData = weatherList.list
            self.tableView.reloadData()
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler: nil))
        self.present(alert, animated: true)
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Weather List"
    }
    
    // MARK: - UI and Constraints methods

    private func setupViews() {
        view.backgroundColor = .white

        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        
        let tableViewItem = UITableView(frame: .zero, style: .grouped)
        tableViewItem.translatesAutoresizingMaskIntoConstraints = false
        tableViewItem.showsVerticalScrollIndicator = false
        tableViewItem.showsHorizontalScrollIndicator = false
        tableViewItem.delegate = self
        tableViewItem.dataSource = self
        tableViewItem.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.reuseIdentifier)
        tableViewItem.isHidden = false
        tableViewItem.backgroundColor = .white
        tableViewItem.separatorStyle = .none
        tableViewItem.clipsToBounds = true

        self.view.addSubview(tableViewItem)
        self.view.addSubview(activityIndicator)

        self.tableView = tableViewItem
        self.activityIndicator = activityIndicator
        
        setupConstraints()
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return weatherListData.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        return UIView()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseIdentifier, for: indexPath) as! WeatherTableViewCell
        let weatherData = weatherListData[indexPath.item]
        cell.loadData(data: weatherData)
        cell.selectionStyle = .none
        cell.setNeedsLayout()
        cell.layoutIfNeeded()

        return cell
    }
}
