//
//  DistrictPickTableViewCell.swift
//  BatiOS_HW
//
//  Created by Michael Namara on 2023/6/22.
//

import UIKit

class DistrictPickTableViewCell: UITableViewCell {
    
    private let districtLabel: UILabel = {
        let label = UILabel()
        label.deactiveAutoresizingMask()
        label.text = "test"
        label.font = .PingFangTC(fontSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            districtLabel.textColor = .customsRGB(r: 184, g: 204, b: 31)
        } else {
            districtLabel.textColor = .black
        }
    }
    
    private func setupUI() {
        contentView.backgroundColor = .customsRGB(r: 246, g: 246, b: 246)
        contentView.addSubview(districtLabel)
        
        NSLayoutConstraint.activate([
            districtLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            districtLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
    
    func configure(text: String) {
        districtLabel.text = text
    }
}
