//
//  CategoryCell.swift
//  haystekEcomLite
//
//  Created by Sandeep on 23/08/25.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    private let imageBackgroundView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        imageBackgroundView.backgroundColor = ThemeColor.hexStringToUIColor(hex: "F5F5F5")
        imageBackgroundView.layer.cornerRadius = 30
        imageBackgroundView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ThemeColor.hexStringToUIColor(hex: "000000")
        
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.textColor = ThemeColor.hexStringToUIColor(hex: "000000")
        titleLabel.numberOfLines = 0
        
        imageBackgroundView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 28),
            imageView.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [imageBackgroundView, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageBackgroundView.widthAnchor.constraint(equalToConstant: 60),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with title: String, systemImageName: String) {
        titleLabel.text = title
        imageView.image = UIImage(systemName: systemImageName)
    }
}
