//
//  HomeViewController.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 29.07.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
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
        
        view.backgroundColor = .systemRed
        setupTableView()
    }
    
    private func setupTableView() {
        weatherTableView = UITableView()
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.weahterCellIdentifier)
        weatherTableView.showsVerticalScrollIndicator = false
        weatherTableView.separatorStyle = .none
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(weatherTableView)
        weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.weahterCellIdentifier, for: indexPath)
        cell.textLabel?.text = "Title"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.getData()
    }
    
}

