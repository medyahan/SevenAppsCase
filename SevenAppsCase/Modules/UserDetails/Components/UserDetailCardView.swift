//
//  UserDetailView.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

final class UserDetailCardView: UIView { // final ekledik çünkü miras alınmayacak
    
    private let stackView = UIStackView()
    
    init(title: String, details: [String], icon: String) {
        super.init(frame: .zero)
        setupUI()
        configureContent(title: title, details: details, icon: icon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        applyCardStyle()
        
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func configureContent(title: String, details: [String], icon: String) {
        let titleStack = createTitleStack(title: title, icon: icon)
        
        stackView.addArrangedSubview(titleStack)
        stackView.addArrangedSubview(createDivider())
        
        details.forEach { detail in
            stackView.addArrangedSubview(createLabel(text: "• \(detail)"))
        }
    }
    
    private func createTitleStack(title: String, icon: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        
        let iconImageView = UIImageView(image: UIImage(named: icon)?.withRenderingMode(.alwaysTemplate))
        iconImageView.tintColor = .secondary
        iconImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let titleLabel = createLabel(text: title, isSubTitle: true)
        
        stack.addArrangedSubview(iconImageView)
        stack.addArrangedSubview(titleLabel)
        
        return stack
    }
    
    private func createDivider() -> UIView {
        let divider = UIView()
        divider.applyDividerStyle()
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
        return divider
    }
    
    private func createLabel(text: String, isSubTitle: Bool = false) -> UILabel {
        let label = UILabel()
        label.text = text
        if isSubTitle {
            label.applySubTitleStyle()
        } else {
            label.applyDescriptionStyle()
        }
        return label
    }
}
