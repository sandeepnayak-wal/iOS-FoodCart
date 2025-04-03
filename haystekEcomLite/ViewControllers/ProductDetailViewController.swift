//
//  ProductDetailViewController.swift
//  haystekEcomLite
//
//  Created by Sandeep on 02/04/25.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    private var product: ProductModel
    private var isFavorite: Bool = false
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private let contentView = UIView()
    
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.backgroundColor = .systemGray6
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .center
        return sv
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    private let reviewsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    private let approvalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let installmentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 3
        label.textColor = .darkGray
        return label
    }()
    
    private let readMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Read more", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to cart", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let deliveryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initialization
    init(product: ProductModel) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure(with: product)
        setupNavigationBar()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [ratingLabel, reviewsLabel, approvalLabel].forEach {
            ratingContainer.addArrangedSubview($0)
        }
        
        [productImageView, titleLabel, ratingContainer, priceLabel,
         installmentLabel, descriptionLabel, readMoreButton,
         addToCartButton, deliveryLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupConstraints()
        setupActions()
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(backButtonTapped))
        backButton.tintColor = .black
        
        let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(heartButtonTapped))
        heartButton.tintColor = .black
        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(shareButtonTapped))
        shareButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItems = [shareButton, heartButton]
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor, multiplier: 0.8),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            ratingContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            ratingContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: ratingContainer.bottomAnchor, constant: 16),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            installmentLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            installmentLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8),
            
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            readMoreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            readMoreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            addToCartButton.topAnchor.constraint(equalTo: readMoreButton.bottomAnchor, constant: 30),
            addToCartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            
            deliveryLabel.topAnchor.constraint(equalTo: addToCartButton.bottomAnchor, constant: 16),
            deliveryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            deliveryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            deliveryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupActions() {
        readMoreButton.addTarget(self, action: #selector(readMoreTapped), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
    }
    
    // MARK: - Configuration
    func configure(with product: ProductModel) {
        titleLabel.text = product.title
        ratingLabel.text = "\(product.rating.rate) ★"
        reviewsLabel.text = "\(product.rating.count) reviews"
        approvalLabel.text = "\(Int(product.rating.rate * 20))%"
        priceLabel.text = "£\(product.price)"
        installmentLabel.text = "from £\(Int(product.price / 12)) per month"
        descriptionLabel.text = product.description
        deliveryLabel.text = "Delivery on \(estimatedDeliveryDate())"
        
        if let imageURL = URL(string: product.image) {
            productImageView.loadImage(from: imageURL)
        }
    }
    
    private func estimatedDeliveryDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        let date = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
        return dateFormatter.string(from: date)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func heartButtonTapped() {
        isFavorite.toggle()
        
        let heartImageName = isFavorite ? "heart.fill" : "heart"
        navigationItem.rightBarButtonItems?.last?.image = UIImage(systemName: heartImageName)
        navigationItem.rightBarButtonItems?.last?.tintColor = isFavorite ? .systemRed : .black
        
        if isFavorite {
            CartManager.shared.addToCart(product: product)
            showAlert(title: "Added to Cart", message: "\(product.title) has been added to your cart.")
        } else {
            CartManager.shared.removeFromCart(product: product)
            showAlert(title: "Removed from Cart", message: "\(product.title) has been removed from your cart.")
        }
    }

    
    @objc private func shareButtonTapped() {
        let shareText = "Check out this product: \(product.title) - £\(product.price)"
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    @objc private func readMoreTapped() {
        let isExpanded = descriptionLabel.numberOfLines == 0
        descriptionLabel.numberOfLines = isExpanded ? 3 : 0
        readMoreButton.setTitle(isExpanded ? "Read more" : "Read less", for: .normal)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func addToCartTapped() {
        CartManager.shared.addToCart(product: product)
        
        let cartVC = CartViewController()
        navigationController?.pushViewController(cartVC, animated: true)
        
        // Show confirmation
        let alert = UIAlertController(title: "Added to Cart",
                                    message: "\(product.title) has been added to your cart",
                                    preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
}
