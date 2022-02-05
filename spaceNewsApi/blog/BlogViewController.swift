//
//  BlogViewController.swift
//  spaceNewsApi
//
//  Created by Tiago Costa on 05/02/2022.
//

import UIKit
import Alamofire
import AlamofireImage
import SideMenu

class BlogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let identifier = "BlogViewController"
    
    private let cacheManager = CacheManager()

    private let defaultAppearance = false

    @IBOutlet weak var BlogTableView: UITableView!

    var menu : SideMenuNavigationController?

    var blogs = [Blog]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //appearance
        let value = cacheManager.getCacheAppearance() ?? defaultAppearance

        if (value == true){

            print("dark")
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark


        } else if (value == false){

            print("light")
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
        }

        //menu sidebar
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)

        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)

        //navbar title
        self.title = "Blogs"

        BlogTableView.delegate = self
        BlogTableView.dataSource = self

        let apiService = BlogService(baseURL: "https://api.spaceflightnewsapi.net/v3")
        apiService.getRecentBlogs(endPoint: "/blogs")
        apiService.completionHandler { [weak self] (blogs, status, message) in

            if status {
                guard let self = self else { return }
                guard let _blogs = blogs else { return }
                self.blogs = _blogs
                self.BlogTableView.reloadData()
            }
        }

    }

        //click sidebar
        @IBAction func didTapMenu(){
            present(menu!, animated: true)
        }


        //num de sections
        func numberOfSections(in tableView: UITableView) -> Int {

            return 1
        }


        //num de rows por sections
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return blogs.count
        }


        //O QUE A CELL MOSTRA
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BlogTableViewCell

            let blog = blogs[indexPath.row]

            //image Articles list
            if let imageUrl = blog.imageUrl {
                AF.request(imageUrl).responseImage(completionHandler: { (response) in
                   print(response)

                   if case .success(let image) = response.result {
                       cell.imageCell.image = image
                   }

                   })
            }

            //title Articles list
            cell.titleCell?.text = blog.title

            //newsSite Articles list
            cell.newsSiteCell.text = blog.newsSite

            //remove Cell Selection Backgound
            cell.selectionStyle = UITableViewCell.SelectionStyle.none

            return cell
        }


        //AO SELECIONAR UMA CELL - article details
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

            let blog = blogs[indexPath.row]

            let blogId = blog.id
            let idconvert = "\(blogId ?? 0)" //convert int to string

            if let vc = storyboard?.instantiateViewController(identifier: "BlogDetailStoryboard") as? BlogDetailViewController{

                self.navigationController?.pushViewController(vc, animated: true)

                vc.id = idconvert //id
                vc.titleArticle = blog.title ?? "" //title
                vc.Summary = blog.summary ?? "" //summary
                vc.newsSite = blog.newsSite ?? ""
                vc.url = blog.url

                if let imageUrl = blog.imageUrl {

                    vc.img = imageUrl
                }

                //date
                let blogPublishedAt = blog.publishedAt ?? ""

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"

                let theDate = dateFormatter.date(from: blogPublishedAt)!

                //date updatedAt
                let newDateFormatter = DateFormatter()
                newDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                let dateconvertString = newDateFormatter.string(from: theDate)
                let dateconvert = newDateFormatter.date(from: dateconvertString)


                //date current
                let date = Date()
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd HH:mm"
                let datecurrentString = df.string(from: date)
                let datecurrent = df.date(from: datecurrentString)

                //difference between date updatedAt and date current
                let timeInterval = (datecurrent?.timeIntervalSince(dateconvert!))//seconds

                //convert timeInterval (double) to int
                let timeIntervalInt = Int(timeInterval!) //seconds

                //verify date and return
                if timeIntervalInt >= 0 && timeIntervalInt < 60 {

                    vc.updatedAt = "\(timeIntervalInt) seconds ago"


                } else if timeIntervalInt >= 60 && timeIntervalInt < 3600 {

                    let timeMinutes = ((timeIntervalInt % 3600) / 60) //minutes
                    vc.updatedAt = "\(timeMinutes) minutes ago"


                } else if timeIntervalInt >= 3600 && timeIntervalInt < 7200 {

                    let timeHour = ((timeIntervalInt % 86400) / 3600) //hour
                    vc.updatedAt = "\(timeHour) hour ago"


                } else if timeIntervalInt >= 7200 && timeIntervalInt < 86400 {

                    let timeHours = ((timeIntervalInt % 86400) / 3600) //hours
                    vc.updatedAt = "\(timeHours) hours ago"


                } else if timeIntervalInt >= 86400  && timeIntervalInt < 172800 {

                    let timeDay = ((timeIntervalInt / 86400)) //day
                    vc.updatedAt = "\(timeDay) day ago"


                } else if timeIntervalInt >= 172800 {

                    let timeDays = ((timeIntervalInt / 86400)) //days
                    vc.updatedAt = "\(timeDays) days ago"
                }
            }
        }




    //menu sidebar
    class MenuListController: UITableViewController {

        var items = ["Articles", "Blogs", "Reports"]

        override func viewDidLoad() {

            super.viewDidLoad()
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellsidebar")
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return items.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cellsidebar = tableView.dequeueReusableCell(withIdentifier: "cellsidebar", for: indexPath)

            cellsidebar.textLabel?.text = items[indexPath.row]

            return cellsidebar
        }

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            tableView.deselectRow(at: indexPath, animated: true)

            if (items[indexPath.row] == "Articles") {
                
                var BlogStoryboard : UIStoryboard!
                BlogStoryboard = UIStoryboard(name:"Main", bundle: nil)
                
                 let tvc = BlogStoryboard.instantiateViewController(withIdentifier: "TodayStoryboard") as! TodayViewController
                
                    print(items[indexPath.row])
                self.navigationController?.show(tvc, sender: nil)
                
            } else if (items[indexPath.row] == "Blogs") {

                var TodayStoryboard : UIStoryboard!
                TodayStoryboard = UIStoryboard(name:"Main", bundle: nil)
                
                 let bvc = TodayStoryboard.instantiateViewController(withIdentifier: "BlogStoryboard") as! BlogViewController
                
                    print(items[indexPath.row])
                self.navigationController?.show(bvc, sender: nil)
                
                
//                var kaynakStryBrd: UIStoryboard!
//                            kaynakStryBrd = UIStoryboard(name: "Main", bundle: nil)
//                            let ikinciVC = kaynakStryBrd.instantiateViewController(withIdentifier: "BlogStoryboard") as! BlogViewController
//                            self.navigationController?.show(ikinciVC, sender: nil)
//
            } else if (items[indexPath.row] == "Reports") {
                
            }
            
            //do something
        }
    }
}
