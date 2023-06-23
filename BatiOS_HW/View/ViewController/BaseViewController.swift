//
//  BaseViewController.swift
//  BatiOS_HW
//
//  Created by Michael Namara on 2023/6/21.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    var menuIsShow = false
    var cancellables = Set<AnyCancellable>()
    
    let logoImageView: UIImageView = {
        let view = UIImageView()
        view.deactiveAutoresizingMask()
        view.image = UIImage(named: "logo")
        return view
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.isHidden = false
        button.deactiveAutoresizingMask()
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.deactiveAutoresizingMask()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        return button
    }()
    
    lazy var menuView: MenuView = {
        let view = MenuView()
        view.isHidden = true
        view.delegate = self
        view.deactiveAutoresizingMask()
        return view
    }()
    let separatorImageView: UIView = {
        let view = UIView()
        view.deactiveAutoresizingMask()
        view.backgroundColor = .customRgb235
        return view
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.deactiveAutoresizingMask()
        indicator.color = .white
        indicator.layer.cornerRadius = 10
        indicator.hidesWhenStopped = true
        indicator.backgroundColor = UIColor(white: 0.2, alpha: 1)
        return indicator
    }()
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubviews(views: [logoImageView, menuButton, closeButton, separatorImageView, menuView])
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            logoImageView.widthAnchor.constraint(equalToConstant: 65),
            logoImageView.heightAnchor.constraint(equalToConstant: 65),
            
            menuButton.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            menuButton.heightAnchor.constraint(equalToConstant: 12),
            menuButton.widthAnchor.constraint(equalToConstant: 18),
            
            closeButton.centerXAnchor.constraint(equalTo: menuButton.centerXAnchor),
            closeButton.centerYAnchor.constraint(equalTo: menuButton.centerYAnchor),
            
            separatorImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            separatorImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorImageView.heightAnchor.constraint(equalToConstant: 1),
            
            menuView.topAnchor.constraint(equalTo: separatorImageView.bottomAnchor),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func showMenu() {
        if !menuIsShow {
            menuView.isHidden = false
            menuButton.isHidden = true
            closeButton.isHidden = false
        } else {
            menuView.isHidden = true
            menuButton.isHidden = false
            closeButton.isHidden = true
        }
        menuIsShow.toggle()
    }
}

extension BaseViewController: MenuViewDelegate {
    func goToPage(feature: MenuView.Feature) {
        switch feature {
        case .guideline:
            print("1")
        case .paymentMethod:
            print("2")
        case .siteInfo:
            print("3")
        case .news:
            print("4")
        case .event:
            print("5")
        }
        showMenu()
    }
}
