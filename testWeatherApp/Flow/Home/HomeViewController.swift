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
    
    private var searchBar: UISearchBar!
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
        
        view.backgroundColor = .mainColor
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupSearchBar()
        setupTableView()
        
        showLoader()
        viewModel.loadDataSource { [weak self] in
            self?.weatherTableView.reloadData()
            self?.hideLoader()
        }
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        navigationItem.titleView = searchBar
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
        if viewModel.searching {
            return viewModel.searchList.count
        } else {
            return viewModel.dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.weahterCellIdentifier, for: indexPath) as! WeahterTableViewCell
        if viewModel.searching {
            cell.updateView(locationWeather: viewModel.searchList[indexPath.row])
        } else {
            cell.updateView(locationWeather: viewModel.dataSource[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.searching {
            onForecast?(viewModel.searchList[indexPath.row])
        } else {
            onForecast?(viewModel.dataSource[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateSearchList(searchText: searchText)
        viewModel.searching = true
        weatherTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searching = false
        searchBar.text = ""
        weatherTableView.reloadData()
    }
}
