//
//  CollectionViewController.swift
//  Joke Norris
//
//  Created by Developer on 10/02/2019.
//  Copyright © 2019 Farsen. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var manager = FactsManager()
    var page = 1
    let itemsPerRow = 3
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        self.loadData()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = self.collectionView.frame.width
        let width: CGFloat = collectionViewWidth - (10 * CGFloat(itemsPerRow-1))
        let cellWidth: CGFloat = width / CGFloat(self.itemsPerRow)
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        let layout = UICollectionViewLayout()
//        let collectionViewWidth = self.collectionView.frame.width
//        let width = collectionViewWidth - (10 * CGFloat(itemsPerRow-1))
//        layout.itemSiz
//    }
    
    
    func loadData(){
        manager.getImageFacts(page: page, completion: { (facts, error) in
            if error == nil {
                print(self.manager.facts)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return manager.facts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fact", for: indexPath) as! CollectionViewCell
        
        cell.img.image = UIImage.gifImageWithName("loader")
        
        var currentFact = self.manager.facts[indexPath.row]
        let imageUrl:URL = URL(string: currentFact.fact)!
        
        if(currentFact.imageData != nil) {
            cell.img.image = UIImage(data: currentFact.imageData!)
        } else {
            DispatchQueue.global().async {
                let imageData = NSData(contentsOf: imageUrl)!
                DispatchQueue.main.async {
                    currentFact.imageData = imageData as Data
                    cell.img.image = UIImage(data: currentFact.imageData!)
                }
            }
        }
        
        //cell.img.image = UIImage.gifImageWithURL(currentFact.fact)
    
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= self.manager.facts.count - 1 {
            self.page += 1
            self.loadData()
            
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
