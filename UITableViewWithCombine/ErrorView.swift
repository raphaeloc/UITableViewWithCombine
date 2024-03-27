//
//  ErrorView.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 26/03/24.
//

import UIKit

class ErrorView: UIView {
    // MARK: - Inner protocols
    protocol Delegate: AnyObject {
        func didTapOnTryAgainButton()
    }
    
    // MARK: - Containers
    private(set) lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                textsContainerStackView,
                tryAgainButton
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private(set) lazy var textsContainerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleLabel,
                descriptionLabel
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }()
    
    // MARK: - Components
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.font = .boldSystemFont(ofSize: 24)
        
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Error on fetch data, try again later"
        label.font = .systemFont(ofSize: 18, weight: .light)
        
        return label
    }()
    
    private(set) lazy var tryAgainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Try again", for: .normal)
        button.addTarget(self, action: #selector(didTapOnTryAgainButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Variables & Constants
    weak var delegate: ErrorView.Delegate!
    
    // MARK: - Initializers
    init(delegate: ErrorView.Delegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
    private func setup() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(containerStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                containerStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
                containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
                containerStackView.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor),
                containerStackView.trailingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor),
                containerStackView.leadingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor),
                containerStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor),
            ]
        )
    }
    
    // MARK: - Methods
    @objc
    func didTapOnTryAgainButton() {
        delegate.didTapOnTryAgainButton()
    }
}
