//
//  SettingTableViewCell.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 13/12/2021.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"

    
    private let label: UILabel = {
       
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    
    required init?(coder: NSCoder){
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.frame.size.height - 12
        
        label.frame = CGRect(x: 25, y: 0, width: contentView.frame.size.width - 20, height: contentView.frame.size.height)
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
    }
    
    
    public func configure(with model: SettingsOptions){
        
        label.text = model.title
    }
}
