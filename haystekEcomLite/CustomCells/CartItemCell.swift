//
//  CartItemCell.swift
//  haystekEcomLite
//
//  Created by Sandeep on 23/08/25.
//

import UIKit
import Kingfisher

class CartItemCell: UITableViewCell {
    static let reuseIdentifier = "CartItemCell"
    
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .systemGray6
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    private let decrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("−", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.tintColor = .black
        return button
    }()
    
    private let incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.tintColor = .black
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    // stack for quantity controls
    private lazy var quantityStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [decrementButton, quantityLabel, incrementButton])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [selectButton, productImageView, nameLabel, priceLabel, quantityStack].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            selectButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            selectButton.widthAnchor.constraint(equalToConstant: 24),
            selectButton.heightAnchor.constraint(equalToConstant: 24),
            
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            productImageView.leadingAnchor.constraint(equalTo: selectButton.trailingAnchor, constant: 16),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            productImageView.widthAnchor.constraint(equalToConstant: 120),
            productImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: quantityStack.leadingAnchor, constant: -12),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            priceLabel.trailingAnchor.constraint(equalTo: quantityStack.leadingAnchor, constant: -12),
            
            quantityStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            quantityStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            quantityStack.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        selectButton.addTarget(self, action: #selector(selectTapped), for: .touchUpInside)
        incrementButton.addTarget(self, action: #selector(incrementTapped), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decrementTapped), for: .touchUpInside)
    }
    
    func configure(with item: CartItem) {
        nameLabel.text = item.name
        priceLabel.text = "$\(item.price)"
        quantityLabel.text = "\(item.quantity)"
        
        selectButton.setImage(UIImage(systemName: item.isSelected ? "checkmark.square.fill" : "square"),
                              for: .normal)
        
        if let url = URL(string: item.imageUrl) {
            productImageView.kf.setImage(with: url)
        }
    }
    
    @objc private func selectTapped() {
        let isSelected = selectButton.image(for: .normal) == UIImage(systemName: "checkmark.square.fill")
        selectButton.setImage(UIImage(systemName: isSelected ? "square" : "checkmark.square.fill"),
                              for: .normal)
    }
    
    @objc private func incrementTapped() {
        if let value = Int(quantityLabel.text ?? "1") {
            quantityLabel.text = "\(value + 1)"
        }
    }
    
    @objc private func decrementTapped() {
        if let value = Int(quantityLabel.text ?? "1"), value > 1 {
            quantityLabel.text = "\(value - 1)"
        }
    }
}
