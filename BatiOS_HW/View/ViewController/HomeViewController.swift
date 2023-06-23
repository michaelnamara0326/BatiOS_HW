//
//  HomeViewController.swift
//  BatiOS_HW
//
//  Created by Michael Namara on 2023/6/21.
//

import UIKit

class HomeViewController: BaseViewController {
    // MARK: - Init
    private let viewModel: UbikeViewModel
    private var isShow: Bool = false
    private var areaList: [String] = []
    private var filteredAreaSites: [String] = [] {
        didSet {
            ubikeSitesTableView.reloadData()
        }
    }
    private var dataSource: [String:[String]] = [:] {
        didSet {
            self.areaList = Array(self.dataSource.keys).sorted(by: <)
            self.ubikeSitesTableView.reloadData()
            self.areaPickTableView.reloadData()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.deactiveAutoresizingMask()
        label.text = "站點資訊"
        label.textColor = .ubikeGreen
        label.font = .PingFangTC(fontSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.deactiveAutoresizingMask()
        view.layer.cornerRadius = 8
        view.backgroundColor = .customRgb246
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAreaPickView)))
        return view
    }()
    
    private let areaLabel: UILabel = {
        let label = UILabel()
        label.deactiveAutoresizingMask()
        label.text = "搜尋站點"
        label.textColor = .customRgb174
        label.font = .PingFangTC(fontSize: 16, weight: .medium)
        return label
    }()
    
    private let searchIconImageView: UIImageView = {
        let view = UIImageView()
        view.deactiveAutoresizingMask()
        view.image = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .customRgb174
        return view
    }()
    
    private lazy var areaPickTableView: UITableView = {
        let tableView = UITableView()
        tableView.deactiveAutoresizingMask()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 8
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .customRgb246
        tableView.register(AreaPickTableViewCell.self, forCellReuseIdentifier: AreaPickTableViewCell.cellIdentifier)
        return tableView
    }()
    
    private lazy var ubikeSitesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 8
        tableView.layer.borderWidth = 0.5
        tableView.layer.borderColor = UIColor.customRgb174.cgColor
        tableView.backgroundColor = .ubikeGreen
        tableView.sectionHeaderTopPadding = 0
        tableView.deactiveAutoresizingMask()
        tableView.register(UbikeTableViewCell.self, forCellReuseIdentifier: UbikeTableViewCell.cellIdentifier)
        return tableView
    }()
    
    // MARK: - View Cycle
    init(viewModel: UbikeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        viewModel.fetchUbike()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupPickView()
    }

    override func setupUI() {
        super.setupUI()
        
        searchView.addSubviews(views: [areaLabel, searchIconImageView])
        self.view.addSubviews(views: [titleLabel, searchView, ubikeSitesTableView, areaPickTableView, loadingIndicator, menuView])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.topAnchor.constraint(equalTo: separatorImageView.bottomAnchor, constant: 24),
            
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            searchView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            searchView.heightAnchor.constraint(equalToConstant: 40),
            
            areaLabel.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            areaLabel.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 16),
            
            searchIconImageView.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchIconImageView.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -18),
            
            ubikeSitesTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 24),
            ubikeSitesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            ubikeSitesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            ubikeSitesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 100),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // MARK: - Functions
    private func setupBinding() {
        viewModel.$ubikeDataSource
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] in
                self?.dataSource = $0
            }.store(in: &cancellables)
        
        viewModel.isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                if $0 {
                    self?.loadingIndicator.startAnimating()
                } else {
                    self?.loadingIndicator.stopAnimating()
                }
            }.store(in: &cancellables)
    }
    
    private func setupPickView() {
        areaPickTableView.frame = CGRect(x: searchView.frame.origin.x, y: searchView.frame.origin.y + searchView.frame.height + 8, width: searchView.frame.width, height: 0)
    }
    
    @objc private func showAreaPickView() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
            self.areaPickTableView.frame.size.height = self.isShow ? 0 : 232
            self.isShow.toggle()
        }
    }
}

// MARK: - Tableview delegate & datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case areaPickTableView:
            areaLabel.text = areaList[indexPath.row]
            filteredAreaSites = dataSource[areaList[indexPath.row]] ?? []
            areaLabel.textColor = .ubikeGreen
            searchIconImageView.tintColor = .ubikeGreen
            ubikeSitesTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            showAreaPickView()
            
        case ubikeSitesTableView:
            print("ubike site")
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        switch tableView {
        case areaPickTableView:
            row = areaList.count
            
        case ubikeSitesTableView:
            row = filteredAreaSites.count + 1
            
        default:
            break
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case areaPickTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: AreaPickTableViewCell.cellIdentifier, for: indexPath) as! AreaPickTableViewCell
            cell.configure(text: areaList[indexPath.row])
            return cell
            
        case ubikeSitesTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: UbikeTableViewCell.cellIdentifier, for: indexPath) as! UbikeTableViewCell
            if indexPath.row > 0 {
                cell.configure(area: areaLabel.text!, site: filteredAreaSites[indexPath.row - 1], row: indexPath.row - 1)
            }
            return cell
            
        default:
            break
        }
        return UITableViewCell()
    }
}
