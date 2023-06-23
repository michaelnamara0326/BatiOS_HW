//
//  UbikeTableViewCell.swift
//  BatiOS_HW
//
//  Created by Michael Namara on 2023/6/21.
//

import UIKit

class UbikeTableViewCell: UITableViewCell {
    private let titleLabels: [UILabel] = {
        var labels = [UILabel]()
        Ubike.allCases.forEach {
            let label = UILabel()
            label.deactiveAutoresizingMask()
            label.text = $0.rawValue
            label.numberOfLines = 0
            label.textAlignment = .center
            label.lineBreakMode = .byWordWrapping
            label.font = .PingFangTC(fontSize: 16, weight: .medium)
            label.textColor = .white
            labels.append(label)
        }
        return labels
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        contentView.backgroundColor = .ubikeGreen
        for (index, elem) in Ubike.allCases.enumerated() {
            titleLabels[index].font = .PingFangTC(fontSize: 16, weight: .medium)
            titleLabels[index].textColor = .white
            titleLabels[index].text = elem.rawValue
        }
    }
    
    private func setupUI() {
        contentView.backgroundColor = .ubikeGreen
        
        contentView.addSubviews(views: titleLabels)
        NSLayoutConstraint.activate([
            //cityLabel
            titleLabels[0].topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            titleLabels[0].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabels[0].bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            titleLabels[0].widthAnchor.constraint(equalToConstant: 50),
            
            //areaLabel
            titleLabels[1].centerYAnchor.constraint(equalTo: titleLabels[0].centerYAnchor),
            titleLabels[1].leadingAnchor.constraint(equalTo: titleLabels[0].trailingAnchor, constant: 28),
            titleLabels[1].widthAnchor.constraint(equalToConstant: 50),
            
            //siteLabel
            titleLabels[2].centerYAnchor.constraint(equalTo: titleLabels[1].centerYAnchor),
            titleLabels[2].leadingAnchor.constraint(equalTo: titleLabels[1].trailingAnchor, constant: 32),
            titleLabels[2].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabels[2].topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabels[2].bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
//            titleLabels[2].widthAnchor.constraint(equalToConstant: 170)
        ])
        
        
    }
    
    func configure(area: String, site: String, row: Int) {
        contentView.backgroundColor = (row % 2 == 0) ? .white : .customsRGB(r: 246, g: 246, b: 246)
        titleLabels[0].text = "台北市"
        titleLabels[1].text = area
        titleLabels[2].text = site
        for i in 0 ..< Ubike.allCases.count {
            titleLabels[i].textColor = .customsRGB(r: 50, g: 50, b: 50)
            titleLabels[i].font = .PingFangTC(fontSize: 14, weight: .regular)
        }
        
    }
}
extension UbikeTableViewCell {
    enum Ubike: String, CaseIterable {
        case city = "縣市"
        case area = "區域"
        case site = "站點名稱"
    }
}
