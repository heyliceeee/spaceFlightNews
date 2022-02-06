//
//  SettingTableViewCell.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 13/12/2021.
//

import UIKit

class LabelTableViewCell: UITableViewCell {
    
    static let identifier = "LabelTableViewCell"

    
    private let label: UILabel = {
       
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    
    private let myText: UILabel = {
       
        let myText = UILabel()
        myText.numberOfLines = 1
        myText.textColor = .systemGray
        
        return myText
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        contentView.addSubview(myText)
        
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
        
        myText.sizeToFit()
        
        myText.frame = CGRect(x: contentView.frame.size.width - myText.frame.size.width - 20,
                              y: (contentView.frame.size.height - myText.frame.size.height)/2,
                              width: myText.frame.size.width,
                              height: myText.frame.size.height)
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
        myText.text = nil
    }
    
    
    public func configure(with model: SettingsLabelOptions){
        
        label.text = model.title
        myText.text = model.myText
    }
}
