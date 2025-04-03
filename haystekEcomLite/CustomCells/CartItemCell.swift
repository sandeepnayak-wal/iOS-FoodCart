//
//  CartItemCell.swift
//  haystekEcomLite
//
//  Created by Sandeep on 02/04/25.
//

import UIKit

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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [selectButton, productImageView, nameLabel, priceLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            selectButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            selectButton.widthAnchor.constraint(equalToConstant: 24),
            selectButton.heightAnchor.constraint(equalToConstant: 24),
            
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.leadingAnchor.constraint(equalTo: selectButton.trailingAnchor, constant: 16),
            productImageView.widthAnchor.constraint(equalToConstant: 60),
            productImageView.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
        
        selectButton.addTarget(self, action: #selector(selectTapped), for: .touchUpInside)
    }
    
    func configure(with item: CartItem) {
        nameLabel.text = item.name
        priceLabel.text = String(format: "£%.2f", item.price)
        selectButton.setImage(UIImage(systemName: item.isSelected ? "checkmark.square.fill" : "square"),
                           for: .normal)
        
        if let url = URL(string: item.imageUrl) {
            productImageView.loadImage(from: url)
        }
    }
    
    @objc private func selectTapped() {
        let isSelected = selectButton.image(for: .normal) == UIImage(systemName: "checkmark.square.fill")
        selectButton.setImage(UIImage(systemName: isSelected ? "square" : "checkmark.square.fill"),
                            for: .normal)
    }
}
