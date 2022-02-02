//
//  CacheValidityViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 21/12/2021.
//

import UIKit


class CacheValidityViewController: UIViewController {
    
    static let identifier = "CacheValidityViewController"
    
    
    private let tableView: UITableView = {
    
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        
       return table
    }()
    
    
    
}
