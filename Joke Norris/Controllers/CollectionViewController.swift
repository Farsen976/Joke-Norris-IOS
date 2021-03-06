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

    
//    override func viewDidAppear(_ animated: Bool) {
//        let layout = UICollectionViewLayout()
//        let collectionViewWidth = self.collectionView.frame.width
//        let width = collectionViewWidth - (10 * CGFloat(itemsPerRow-1))
//        layout.itemSiz
//    }
    
    
    func loadData(){
        manager.getImageFacts(page: page, completion: { (facts, error) in
            if error == nil {
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
        
        let currentFact = self.manager.facts[indexPath.row]
        
        
        //cell.img.image = UIImage.gifImageWithURL(currentFact.fact)
    
        return cell.constructCell(fact: currentFact)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= self.manager.facts.count - 1 {
            self.page += 1
            self.loadData()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = self.collectionView.frame.width
        let width: CGFloat = collectionViewWidth - (10 * CGFloat(itemsPerRow-1))
        let cellWidth: CGFloat = width / CGFloat(self.itemsPerRow)
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = DetailFactViewController()
//        vc.fact = self.manager.facts[indexPath.row]
//
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailFactViewController {
            
            guard let cell = sender as? CollectionViewCell else { return }
            
            let vc = segue.destination as? DetailFactViewController
            vc?.fact = cell.fact
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
