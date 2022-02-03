//
//  SwitchTableViewCell.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 13/12/2021.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    static let identifier = "SwitchTableViewCell"

    
    private let label: UILabel = {
       
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    
    private let mySwitch: UISwitch = {
       
        let mySwitch = UISwitch()
        mySwitch.onTintColor = .systemPurple
        
        return mySwitch
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        contentView.addSubview(mySwitch)
        
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    
    
    required init?(coder: NSCoder){
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        let size: CGFloat = contentView.frame.size.height - 12
        
        label.frame = CGRect(x: 25, y: 0, width: contentView.frame.size.width - 20, height: contentView.frame.size.height)
        
        
        mySwitch.sizeToFit()
        mySwitch.frame = CGRect(x: contentView.frame.size.width - mySwitch.frame.size.width - 20,
                                y: (contentView.frame.size.height - mySwitch.frame.size.height)/2,
                                width: mySwitch.frame.size.width,
                                height: mySwitch.frame.size.height)
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
        mySwitch.isOn = false
    }
    
    
    public func configure(with model: SettingsSwitchOptions){
        
        label.text = model.title
        mySwitch.isOn = model.isOn
    }
}
