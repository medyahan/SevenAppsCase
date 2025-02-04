//
//  CustomSearchBarView.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

// Arama çubuğundaki metin değiştiğinde bildirim sağlar
protocol CustomSearchBarDelegate: AnyObject {
    func didUpdateSearchText(_ text: String)
}

class CustomSearchBarView: UIView, UITextFieldDelegate {
    
    weak var delegate: CustomSearchBarDelegate?
    
    lazy var searchTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Search..."
        textField.leftIcon = UIImage(named: "search")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.returnKeyType = .search
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchTextField.topAnchor.constraint(equalTo: self.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: searchTextField.customHeight) // Sabit yükseklik
    }
    
    // Metin değiştiğinde çağrılan fonksiyon
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.didUpdateSearchText(textField.text ?? "")
    }
}
