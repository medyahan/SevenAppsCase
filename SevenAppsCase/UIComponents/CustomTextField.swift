//
//  CustomTextField.swift
//  SevenAppsCase
//
//  Created by Medya Han on 3.02.2025.
//

import UIKit

class CustomTextField: UITextField {
    
    let customHeight: CGFloat = 48
    var leftIconColor: UIColor? = .secondary
    var rightIconColor: UIColor? = .secondary
    public var borderColor: UIColor? = .neutralLight
    
    var textColorCustom: UIColor = .secondary // Metin rengi
    var placeholderColorCustom: UIColor = .neutralLight // Placeholder rengi
    
    @IBInspectable var leftIcon: UIImage? {
        didSet { updateLeftView() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = borderColor?.cgColor
        font = UIFont(name: "Poppins-Regular", size: 16)
        updateTextAndPlaceholderColor()
        updateLeftView()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: customHeight)
    }
    
    private func updateLeftView() {
        if let icon = leftIcon {
            let iconSize: CGFloat = 24
            let padding: CGFloat = 15
            let verticalPadding = (customHeight - iconSize) / 2
            
            let iconView = UIImageView(image: icon.withRenderingMode(.alwaysTemplate))
            iconView.contentMode = .scaleAspectFit
            iconView.tintColor = leftIconColor
            iconView.frame = CGRect(x: padding, y: verticalPadding, width: iconSize, height: iconSize)
            
            let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: iconSize + padding, height: customHeight))
            leftContainer.addSubview(iconView)
            
            leftView = leftContainer
            leftViewMode = .always
        } else {
            leftView = nil
            leftViewMode = .never
        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let leftPadding: CGFloat = leftIcon == nil ? 16 : 50
        let rightPadding: CGFloat = 50
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    private func updateTextAndPlaceholderColor() {
        textColor = textColorCustom
        
        guard let placeholder = placeholder else { return }
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColorCustom,
            .font: font ?? UIFont.systemFont(ofSize: 16)
        ]
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
    
    override var placeholder: String? {
        didSet {
            updateTextAndPlaceholderColor()
        }
    }
}
