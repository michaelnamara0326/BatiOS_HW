//
//  AreaPickTableViewCell.swift
//  BatiOS_HW
//
//  Created by Michael Namara on 2023/6/22.
//

import UIKit

class AreaPickTableViewCell: UITableViewCell {
    
    private let areaLabel: UILabel = {
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
        areaLabel.textColor = selected ? .ubikeGreen : .black
    }
    
    private func setupUI() {
        contentView.backgroundColor = .customRgb246
        contentView.addSubview(areaLabel)
        
        NSLayoutConstraint.activate([
            areaLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            areaLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            areaLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(text: String) {
        areaLabel.text = text
    }
}
