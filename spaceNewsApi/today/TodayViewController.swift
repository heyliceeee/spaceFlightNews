//
//  TodayViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import UIKit

class TodayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var articles = ArticleService()
    
    @IBOutlet weak var ArticlesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ArticlesTableView.delegate = self
        ArticlesTableView.dataSource = self
        ArticlesTableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        
        articles.fetch()
    }
    
    
    //num de linhas maybe
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    //num de rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell
        
        //backgroundColor da cell
        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        //image API
        //cell.imageCell.image = self. ... [indexPath.row]
        
        //title API
        //cell.titleCell.text = self. ... [indexPath.row]
        
        //summary API
        //cell.summaryCell.text = self. ... [indexPath.row]
        
        
        return cell
    }
}
