//
//  TodayViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import UIKit

class TodayViewController: UIViewController {
    
    @IBOutlet weak var IDlabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var imageurlLabel: UILabel!
    @IBOutlet weak var newssiteLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var publishedatLabel: UILabel!
    @IBOutlet weak var updatedatLabel: UILabel!
    @IBOutlet weak var featuredLabel: UILabel!
    @IBOutlet weak var launchesLabel: UILabel!
    @IBOutlet weak var eventsLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btn(_ sender: Any) {
        ArticleService.listArticles() { (article) in
            DispatchQueue.main.sync {
                self.IDlabel.text = "ID: \(article.id)"
                self.IDlabel.text = "Title: \(article.title)"
                self.IDlabel.text = "URL: \(article.url)"
                self.IDlabel.text = "ImageURL: \(article.imageUrl)"
                self.IDlabel.text = "NewsSite: \(article.newsSite)"
                self.IDlabel.text = "Summary: \(article.summary)"
                self.IDlabel.text = "PublishedAt: \(article.publishedAt)"
                self.IDlabel.text = "UpdatedAt: \(article.updatedAt)"
                self.IDlabel.text = "Featured: \(article.featured)"
                self.IDlabel.text = "Launches: \(article.launches)"
                self.IDlabel.text = "Events: \(article.events)"
            }
        }
    }
}
