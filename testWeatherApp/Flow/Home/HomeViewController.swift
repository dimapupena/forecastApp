//
//  HomeViewController.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 29.07.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    var onForecast: ((LocationWeatherData) -> Void)?
    
    static private let weahterCellIdentifier = "WeatherTableViewCell"
    private var viewModel: HomeViewModel!
    
    private var weatherTableView: UITableView!
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 217/255.0, green: 202/255.0, blue: 202/255.0, alpha: 1.0)
        setupTableView()
        
        showLoader()
        viewModel.loadDataSource { [weak self] in
            self?.weatherTableView.reloadData()
            self?.hideLoader()
        }
    }
    
    private func setupTableView() {
        weatherTableView = UITableView()
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.backgroundColor = .clear
        weatherTableView.register(WeahterTableViewCell.self, forCellReuseIdentifier: Self.weahterCellIdentifier)
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(weatherTableView)
        weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.weahterCellIdentifier, for: indexPath) as! WeahterTableViewCell
        cell.updateView(locationWeather: viewModel.dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onForecast?(viewModel.dataSource[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
