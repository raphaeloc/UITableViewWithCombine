//
//  TableViewCell.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 26/03/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Containers
    private lazy var containerStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                iconImageView,
                textStackView,
                chevronIconImageView
            ]
        )
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        return stackView
    }()
    
    private lazy var textStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleLabel,
                descriptionLabel
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        return stackView
    }()
    
    
    // MARK: - Components
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.fill.checkmark"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        
        return label
    }()
    
    private lazy var chevronIconImageView: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(
                systemName: "chevron.right",
                withConfiguration: UIImage.SymbolConfiguration(weight: .light)
            )
        )
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Setup methods
    private func setup() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        addSubview(containerStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                containerStackView.topAnchor.constraint(equalTo: topAnchor),
                containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ]
        )
    }
    
    func setup(item: Item) {
        iconImageView.image = UIImage(systemName: item.icon)
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
}
