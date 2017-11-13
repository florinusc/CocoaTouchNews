//
//  ArticleViewController.swift
//  CocoaTouchNews
//
//  Created by Florin Uscatu on 11/7/17.
//  Copyright © 2017 Florin Uscatu. All rights reserved.
//

import UIKit
import Kanna
import SafariServices


class ArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article] = []
    var categories: [String] = []
    
    var text: String? {
        didSet {
            DispatchQueue.global().async {
                self.parseHTML(html: self.text!)
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func parseHTML(html: String) {
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            
            var currentHeader = ""
            
            for link in doc.xpath("//h2 | //strong/a") {
                
                if link["href"] == nil {
                    
                    if currentHeader != link.text {
                        if link.text != "As always…" {
                            currentHeader = link.text!
                            categories.append(link.text!)
                        }
                    }
                    
                } else {
                    articles.append(Article(name: link.text!, category: currentHeader, link: link["href"]!))
                    
                }
                
            }
            
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var categoryArticles: [Article] = []
        
        for article in articles {
            if article.category == categories[section] {
                categoryArticles.append(article)
            }
        }
        
        return categoryArticles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentArticle = articles.filter() {$0.category == categories[indexPath.section]}[indexPath.row]

        cell.textLabel?.text = currentArticle.name
        
        return cell
    }
    
    var selectedURL = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedArticle = articles.filter() {$0.category == categories[indexPath.section]}[indexPath.row]
        
        selectedURL = selectedArticle.link
        
        if let url = URL(string: selectedURL) {
            let svc = SFSafariViewController(url: url)
            self.present(svc, animated: true, completion: nil)
        }
        
    }

}
