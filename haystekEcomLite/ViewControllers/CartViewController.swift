//
//  SearchViewController.swift
//  haystekEcomLite
//
//  Created by Sandeep on 01/04/25.
//

import UIKit

class CartViewController: UIViewController {
    
    // MARK: - UI Components
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Cart"
        label.textAlignment = .center
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private let selectAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select all", for: .normal)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.tintColor = .systemBlue
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.register(CartItemCell.self, forCellReuseIdentifier: "CartItemCell")
        return tv
    }()
    
    private let checkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Checkout", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    private var cartItems: [CartItem] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        updateTime()
        loadCartItems()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        [timeLabel, titleLabel, addressLabel, selectAllButton, tableView, checkoutButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            selectAllButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 16),
            selectAllButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: selectAllButton.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -16),
            
            checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            checkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        selectAllButton.addTarget(self, action: #selector(selectAllTapped), for: .touchUpInside)
        checkoutButton.addTarget(self, action: #selector(checkoutTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    private func updateTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timeLabel.text = formatter.string(from: Date())
    }
    
    private func loadCartItems() {
        cartItems = CartManager.shared.getCartItems()
        addressLabel.text = "92 High Street, London" // Replace with user's actual address
        tableView.reloadData()
        updateCheckoutButton()
    }
    
    private func updateCheckoutButton() {
        let total = cartItems.reduce(0) { $0 + ($1.isSelected ? $1.price * Double($1.quantity) : 0) }
        checkoutButton.setTitle("Checkout (£\(String(format: "%.2f", total)))", for: .normal)
    }
    
    // MARK: - Actions
    @objc private func selectAllTapped() {
        let allSelected = cartItems.allSatisfy { $0.isSelected }
        cartItems.indices.forEach { cartItems[$0].isSelected = !allSelected }
        CartManager.shared.cartItems = cartItems
        selectAllButton.setImage(UIImage(systemName: allSelected ? "square" : "checkmark.square.fill"),
                               for: .normal)
        tableView.reloadData()
        updateCheckoutButton()
    }
    
    @objc private func checkoutTapped() {
        cartItems.removeAll{ $0.isSelected}
        tableView.reloadData()
        updateCheckoutButton()
        let alert = UIAlertController(title: "Thank You!", message: "Your order has been placed successfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
                                                

// MARK: - UITableViewDataSource & Delegate
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemCell
        cell.configure(with: cartItems[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

