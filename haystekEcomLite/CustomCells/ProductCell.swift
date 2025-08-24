//
//  ProductCell.swift
//  haystekEcomLite
//
//  Created by Sandeep on 23/08/25.
//

import UIKit
import Kingfisher

protocol ProductCellDelegate: AnyObject {
    func didUpdateFavorite(for category: MealCategory, isAdded: Bool)
}

class ProductCell: UICollectionViewCell {
    
    weak var delegate: ProductCellDelegate?
    private var categoryItem: MealCategory?
    
    // MARK: - UI Components
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .systemGray6
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        return button
    }()
    
    private var currentImageURL: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupFavoriteButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        currentImageURL = nil
    }
    
    // MARK: - Setup
    private func setupViews() {
        let priceStack = UIStackView(arrangedSubviews: [priceLabel, originalPriceLabel])
        priceStack.axis = .horizontal
        priceStack.spacing = 4
        
        let stackView = UIStackView(arrangedSubviews: [productImageView, titleLabel, priceStack])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        contentView.addSubview(stackView)
        contentView.addSubview(favoriteButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: 180),
            productImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupFavoriteButton() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func favoriteButtonTapped() {
        guard let category = categoryItem else { return }
        
        let isFavorite = favoriteButton.currentImage == UIImage(systemName: "heart.fill")
        let newImage = isFavorite ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
        favoriteButton.setImage(newImage, for: .normal)
        favoriteButton.tintColor = isFavorite ? .white : .systemRed
        
        delegate?.didUpdateFavorite(for: category, isAdded: !isFavorite)
    }
    
    // MARK: - Configuration
    func configure(with category: MealCategory) {
        self.categoryItem = category
        
        titleLabel.text = category.strCategory
        priceLabel.text = "$112.90" // Hardcoded
        originalPriceLabel.text = "$100.90"         
        titleLabel.sizeToFit()
        
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .white
        
        if let url = URL(string: category.strCategoryThumb) {
            productImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ]
            )
        }
    }
}
