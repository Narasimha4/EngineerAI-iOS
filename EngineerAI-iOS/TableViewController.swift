//
//  TableViewController.swift
//  EngineerAI-iOS
//
//  Created by Narasimha on 12/06/19.
//  Copyright © 2019 fissionlabs. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class TableViewController: UITableViewController {
    
    @IBOutlet weak var footer: UIView!
    var hud: MBProgressHUD = MBProgressHUD()
    var hits = [Hits]()
    var pageOffset = 0 // total number of pages, initial value is 0
    var offset = 1 // current page
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
    }
    
    func loading(view:UIView) {
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
    func getPosts() {
        APIHelper().getTotalPosts(page:offset, onCompletion: { (data, response, err) in
            self.loading(view: self.view)
            if let hitsList = response?["hits"], let pages = response!["nbPages"] as? Int {
                self.pageOffset = pages
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: hitsList, options: .prettyPrinted)
                    self.getPostList(with: jsonData)
                } catch {}
            } else {
                self.hud.hide(animated: true)
            }
        }, onFailure: { (err) in
            self.hud.hide(animated: true)
        })
    }
    
    func getPostList(with data:Data) {
        do {
            let newHits = try JSONDecoder().decode([Hits].self, from:data)
            hits.append(contentsOf: newHits)
            offset += 1
            self.title = "Total Posts : \(hits.count)"
            tableView.reloadData()
            hud.hide(animated: true)
        } catch {
        }
    }
    
    //MARK:Delegate method to return title in header section
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8; // space b/w cells
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.clear
        return header
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if hits.count == 0 {
            let rect = CGRect(x: 0,
                              y: 0,
                              width: self.tableView.bounds.size.width,
                              height: self.tableView.bounds.size.height)
            let noDataLabel: UILabel = UILabel(frame: rect)
            noDataLabel.numberOfLines = 0
            noDataLabel.text = "Loading...."
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = noDataLabel
            self.tableView.separatorStyle = .none
            footer.isHidden = true
            guard ReachabilityManager.shared.isConnectedToNetwork() else {
                noDataLabel.text = "Please check internet connection"
                return 0
            }
            return 0
        } else {
            self.tableView.backgroundView = nil
            footer.isHidden = false
            return hits.count
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.title.text = hits[indexPath.section].title
        cell.createdAt.text = "Created at: \(hits[indexPath.section].created_at ?? "")"
        if indexPath.section == hits.count - 1 {
            self.autoLoad()
        }
        return cell
    }
    
    func autoLoad() {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                if self.offset < self.pageOffset {
                    self.getPosts()
                    self.loading(view: self.footer)
                }
            }
        }
    }
}


