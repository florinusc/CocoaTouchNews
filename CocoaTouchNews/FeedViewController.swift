//
//  ViewController.swift
//  CocoaTouchNews
//
//  Created by Florin Uscatu on 11/7/17.
//  Copyright © 2017 Florin Uscatu. All rights reserved.
//

import UIKit


class FeedViewController: UICollectionViewController {

    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        DispatchQueue.global().async {
            self.requestData()
        }
        
    }
    

    func requestData() {
        let urlString = "https://weeklycocoa.news/feed.json"
        if let url = URL(string: urlString) {
        
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) {
                (data, response, error) -> Void in
                
                if error == nil {
                    
                    do {
                        //let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                        
                        self.items = try JSONDecoder().decode(InitialResponse.self, from: data!).items
                        
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                        
                    } catch let err {
                        print(err)
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        cell.titleLabel.text = items[indexPath.row].title
        cell.descriptionView.text = items[indexPath.row].summary
        
        return cell
    }
    
    var selectedIndex: Int?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        
        performSegue(withIdentifier: "goToArticle", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToArticle" {
            let dest = segue.destination as! ArticleViewController
            
            if selectedIndex != nil {
                
                dest.text = items[selectedIndex!].content_html
                selectedIndex = nil
            }
        }
    }
    
    private let sectionInsets = UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20)
    private let numberOfItemsPerRow = 1
    
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.bounds.width - (sectionInsets.left + sectionInsets.right)
        
        return CGSize(width: width, height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}






