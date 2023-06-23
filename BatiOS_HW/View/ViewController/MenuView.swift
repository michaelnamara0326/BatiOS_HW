//
//  MenuView.swift
//  BatiOS_HW
//
//  Created by Michael Namara on 2023/6/21.
//

import UIKit

protocol MenuViewDelegate: AnyObject {
    func goToPage(feature: MenuView.Feature)
}

class MenuView: UIView {
    private var menuSelected: UIButton?
    weak var delegate: MenuViewDelegate?
    
    private lazy var titleButtons: [UIButton] = {
        var buttons = [UIButton]()
        Feature.allCases.forEach {
            let button = UIButton()
            let attributed = NSAttributedString(string: $0.rawValue, attributes: [.font: UIFont.PingFangTC(fontSize: 18, weight: .medium), .foregroundColor: UIColor.white, .kern : 7])
            let attributedSelected = NSAttributedString(string: $0.rawValue, attributes: [.font: UIFont.PingFangTC(fontSize: 18, weight: .medium), .foregroundColor: UIColor.customsRGB(r: 103, g: 117, b: 16), .kern : 7])
            button.setAttributedTitle(attributed, for: .normal)
            button.setAttributedTitle(attributedSelected, for: .selected)
            button.addTarget(self, action: #selector(goToPage), for: .touchUpInside)
            button.accessibilityIdentifier = $0.rawValue
            button.deactiveAutoresizingMask()
            buttons.append(button)
        }
        return buttons
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 32
        stackView.alignment = .fill
        stackView.deactiveAutoresizingMask()
        return stackView
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("登入", for: .normal)
        button.setTitleColor(.customsRGB(r: 181, g: 204, b: 34), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.deactiveAutoresizingMask()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        for button in titleButtons {
            buttonStackView.addArrangedSubview(button)
        }
        
        backgroundColor = .customsRGB(r: 181, g: 204, b: 34)
        addSubviews(views: [loginButton, buttonStackView])
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            buttonStackView.widthAnchor.constraint(equalToConstant: 100),
            buttonStackView.heightAnchor.constraint(equalToConstant: 248),
            
            
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
            loginButton.widthAnchor.constraint(equalToConstant: 80),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func goToPage(sender: UIButton) {
        if let feat = Feature(rawValue: sender.accessibilityIdentifier ?? "") {
            if menuSelected != sender {
                sender.isSelected = true
                menuSelected?.isSelected = false
            }
            menuSelected = sender
            delegate?.goToPage(feature: feat)
        }
    }
    
}
extension MenuView {
    enum Feature: String, CaseIterable {
        case guideline = "使用說明"
        case paymentMethod = "收費方式"
        case siteInfo = "站點資訊"
        case news = "最新消息"
        case event = "活動專區"
    }
}

