//
//  ArticleTableViewCell.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 08/01/2022.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var summaryCell: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
