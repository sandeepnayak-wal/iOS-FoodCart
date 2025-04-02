//
//  HomeViewController.swift
//  haystekEcomLite
//
//  Created by Sandeep on 01/04/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Top Section
    private let deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery address"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "92 High Street, London"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search the entire shop"
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        return searchBar
    }()
    
    private let promoLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery is 50% cheaper"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .systemBlue
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()
    
    // Categories Section
    private let categoriesTitle: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
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
    
    // Flash Sale Section
    private let flashSaleTitle: UILabel = {
        let label = UILabel()
        label.text = "Flash Sale"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "02:59:23"
        label.font = .monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        label.textColor = .red
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
    }
    
    private func setupUI() {
        view.backgroundColor = .white
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
          
            // Promo Label
            promoLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            promoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            promoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            promoLabel.heightAnchor.constraint(equalToConstant: 40),
            
            // Categories Section
            categoriesTitle.topAnchor.constraint(equalTo: promoLabel.bottomAnchor, constant: 24),
            categoriesTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            seeAllButton.centerYAnchor.constraint(equalTo: categoriesTitle.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            categoriesCollectionView.topAnchor.constraint(equalTo: categoriesTitle.bottomAnchor, constant: 16),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            // Flash Sale Section
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
        // Create settings button
        let settingsButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingsButtonTapped)
        )
        
        // Create notification button (without badge)
        let notificationButton = UIBarButtonItem(
            image: UIImage(systemName: "bell.fill"),
            style: .plain,
            target: self,
            action: #selector(notificationButtonTapped)
        )
        
        // Add buttons to navigation bar
        navigationItem.leftBarButtonItem = settingsButton
        navigationItem.rightBarButtonItem = notificationButton
        
        // Customize appearance
        navigationController?.navigationBar.tintColor = .black
    }

    @objc private func settingsButtonTapped() {
        // Handle settings button tap
        print("Settings button tapped")
    }

    @objc private func notificationButtonTapped() {
        // Handle notification button tap
        print("Notification button tapped")
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = categories[indexPath.item]
        cell.configure(with: category.0, systemImageName: category.1)
        return cell
    }
}
