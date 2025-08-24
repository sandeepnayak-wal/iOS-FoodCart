//
//  HomeViewController.swift
//  haystekEcomLite
//
//  Created by Sandeep on 23/08/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    private let deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery address"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = ThemeColor.hexStringToUIColor(hex: "666666")
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "92 High Street, London"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = ThemeColor.hexStringToUIColor(hex: "000000")
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search the entire shop"
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        searchBar.barTintColor = ThemeColor.hexStringToUIColor(hex: "F5F5F5")
        return searchBar
    }()
    
    private let promoLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery is 50% cheaper"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = ThemeColor.hexStringToUIColor(hex: "FFFFFF")
        label.backgroundColor = ThemeColor.hexStringToUIColor(hex: "59C36A")
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()
    
    private let categoriesTitle: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = ThemeColor.hexStringToUIColor(hex: "000000")
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.setTitleColor(ThemeColor.hexStringToUIColor(hex: "59C36A"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 100)
        layout.minimumInteritemSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let flashSaleTitle: UILabel = {
        let label = UILabel()
        label.text = "Flash Sale"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = ThemeColor.hexStringToUIColor(hex: "000000")
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "02:59:23"
        label.font = .monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        label.textColor = ThemeColor.hexStringToUIColor(hex: "000000")
        label.backgroundColor = ThemeColor.hexStringToUIColor(hex: "D9F504")
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()
    
    private let productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 220)
        layout.minimumInteritemSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let categories = [
        ("Phones", "phone"),
        ("Consoles", "gamecontroller"),
        ("Laptops", "laptopcomputer"),
        ("Cameras", "camera"),
        ("Audio", "headphones")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchMealCategories()
    }
    
    private func setupUI() {
        view.backgroundColor = ThemeColor.hexStringToUIColor(hex: "FFFFFF")
        view.addSubview(deliveryLabel)
        view.addSubview(addressLabel)
        view.addSubview(searchBar)
        view.addSubview(promoLabel)
        view.addSubview(categoriesTitle)
        view.addSubview(seeAllButton)
        view.addSubview(categoriesCollectionView)
        view.addSubview(flashSaleTitle)
        view.addSubview(timerLabel)
        view.addSubview(productsCollectionView)
        
        setupConstraints()
        setupNavigationBar()
        
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
    }
    
    private func setupConstraints() {
        deliveryLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        promoLabel.translatesAutoresizingMaskIntoConstraints = false
        categoriesTitle.translatesAutoresizingMaskIntoConstraints = false
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        flashSaleTitle.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        productsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deliveryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            deliveryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: deliveryLabel.bottomAnchor, constant: 4),
            addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            searchBar.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            promoLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            promoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            promoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            promoLabel.heightAnchor.constraint(equalToConstant: 40),
            
            categoriesTitle.topAnchor.constraint(equalTo: promoLabel.bottomAnchor, constant: 24),
            categoriesTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            seeAllButton.centerYAnchor.constraint(equalTo: categoriesTitle.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            categoriesCollectionView.topAnchor.constraint(equalTo: categoriesTitle.bottomAnchor, constant: 16),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            flashSaleTitle.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 24),
            flashSaleTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            timerLabel.centerYAnchor.constraint(equalTo: flashSaleTitle.centerYAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: flashSaleTitle.trailingAnchor, constant: 16),
            
            productsCollectionView.topAnchor.constraint(equalTo: flashSaleTitle.bottomAnchor, constant: 16),
            productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productsCollectionView.heightAnchor.constraint(equalToConstant: 240),
        ])
    }
    
    private func setupNavigationBar() {
        let settingsButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingsButtonTapped)
        )
        
        let notificationButton = UIBarButtonItem(
            image: UIImage(systemName: "bell.fill"),
            style: .plain,
            target: self,
            action: #selector(notificationButtonTapped)
        )
        
        navigationItem.leftBarButtonItem = settingsButton
        navigationItem.rightBarButtonItem = notificationButton
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func settingsButtonTapped() {
        // Does nothing as of now
    }
    
    @objc private func notificationButtonTapped() {
        // Does nothing as of now
    }
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.productsCollectionView.reloadData()
            }
        }
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error",
                                              message: errorMessage,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return categories.count
        } else {
            return viewModel.mealCategories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            let category = categories[indexPath.item]
            cell.configure(with: category.0, systemImageName: category.1)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            let mealCategory = viewModel.mealCategories[indexPath.item]
            cell.configure(with: mealCategory)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productsCollectionView {
            let selectedCategory = viewModel.mealCategories[indexPath.item]
            let detailVC = MealDetailViewController(category: selectedCategory)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
