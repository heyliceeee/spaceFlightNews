//
//  MoreViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 13/12/2021.
//

import UIKit


struct Section {
    let title: String
    let options: [SettingsOptionsType]
}


enum SettingsOptionsType {
    
    case staticCell(model: SettingsOptions)
    case switchCell(model: SettingsSwitchOptions)
    case labelCell(model: SettingsLabelOptions)
    case onlyLabelCell(model: SettingsOnlyLabelOptions)
}


struct SettingsOnlyLabelOptions {
    let title: String
    let myText: String
    let handler: (() -> Void)
}


struct SettingsLabelOptions {
    let title: String
    let myText: String
    let handler: (() -> Void)
}


struct SettingsSwitchOptions {
    let title: String
    let handler: (() -> Void)
    var isOn: Bool
}
	

struct SettingsOptions {
    let title: String
    let handler: (() -> Void)
}


class MoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        table.register(LabelTableViewCell.self, forCellReuseIdentifier: LabelTableViewCell.identifier)
        table.register(OnlyLabelTableViewCell.self, forCellReuseIdentifier: OnlyLabelTableViewCell.identifier)
        
        return table
    }()
    
    
    var models = [Section]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navbar
        //title = "More"
        //navigationItem.title = "More"
        
        //table
        configure()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    
    func configure() {
        
        models.append(Section(title: "SETTINGS", options: [
            
            .labelCell(model: SettingsLabelOptions(title: "Cache Validity", myText: "2 hours", handler: {
                

                let cVVC = self.storyboard?.instantiateViewController(withIdentifier: "CacheValidityStoryboard")
                //self.navigationController?.pushViewController(cVVC!, animated: true)

            })),
            
            .labelCell(model: SettingsLabelOptions(title: "Appearance", myText: "Dark", handler: {})),
            
            .staticCell(model: SettingsOptions(title: "Text Size"){}),
            
            .switchCell(model: SettingsSwitchOptions(title: "Notifications", handler: {}, isOn: true)),
            
            .labelCell(model: SettingsLabelOptions(title: "Use Network", myText: "Wi-Fi and Mobile Data", handler: {}))
        ]))
        
        //models.append(Section(title: "USE NETWORK", options: [
            //.checkCell(model: SettingsCheckOptions(title: "Wi-Fi", handler: {  })),
            
            //.checkCell(model: SettingsCheckOptions(title: "Mobile Data", handler: {})),
            
            //.checkCell(model: SettingsCheckOptions(title: "Wi-Fi and Mobile Data", handler: {})),
        //]))
        
        models.append(Section(title: "SUPPORT", options: [
            .staticCell(model: SettingsOptions(title: "Help Center"){}),
            
            .staticCell(model: SettingsOptions(title: "Contact Us"){}),
            
            .staticCell(model: SettingsOptions(title: "FAQ"){})
        ]))
        
        models.append(Section(title: "ABOUT", options: [
            .onlyLabelCell(model: SettingsOnlyLabelOptions(title: "Version", myText: "v1.0.1", handler: {})),
            
            .onlyLabelCell(model: SettingsOnlyLabelOptions(title: "Privacy Policy", myText: "", handler: {}))
        ]))
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let section = models[section]
        
        return section.title
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return models.count
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return models[section].options.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section].options[indexPath.row]
        
        
        switch model.self {
            case .staticCell(let model):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
                    
                    return UITableViewCell()
                }
                
                cell.configure(with: model)
                
                return cell
            
            
            case .switchCell(let model):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as? SwitchTableViewCell else {
                    
                    return UITableViewCell()
                }
                
                cell.configure(with: model)
                
                return cell
            
            
        case .labelCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as? LabelTableViewCell else {
                
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            
            return cell
            
            
        case .onlyLabelCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OnlyLabelTableViewCell.identifier, for: indexPath) as? OnlyLabelTableViewCell else {
                
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let type = models[indexPath.section].options[indexPath.row]
        
        //performSegue(withIdentifier: "showCacheValidity", sender: self)
        
        switch type.self {
            case .staticCell(let model):
                model.handler()
            
            
            case .switchCell(let model):
                model.handler()
            
            
            case .labelCell(let model):
                model.handler()
            
            
            case .onlyLabelCell(let model):
                model.handler()
        }
    }

}
