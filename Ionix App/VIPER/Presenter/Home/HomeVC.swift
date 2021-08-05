//
//  HomeVC.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 04/08/21.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var contentCollection: UICollectionView!
    @IBOutlet var searcher: UISearchBar!
    @IBOutlet var viewContent: UIView!
    @IBOutlet var viewError: UIView!
    
    private var arrayContent: [ContentEntity]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewController()
        // Do any additional setup after loading the view.
    }
    
    private func initViewController(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "engine"), style: .plain, target: self, action: #selector(addTapped))
        
        arrayContent = [ContentEntity]()
        arrayContent?.append(ContentEntity(
                                image: UIImage(named: "backgroundPlaceholder"),
                                urlImage: "",
                                title: "Hola",
                                score: 7,
                                num_comments: 35))
        
        arrayContent?.append(ContentEntity(
                                image: UIImage(named: "backgroundPlaceholder"),
                                urlImage: "",
                                title: "Adiós",
                                score: 10,
                                num_comments: 53))
        
        self.contentCollection.dataSource = self
        self.contentCollection.delegate = self
        self.contentCollection.register(UINib(nibName: "ItemContentCell", bundle: nil), forCellWithReuseIdentifier: "itemContentCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayContent!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemContentCell", for: indexPath) as! ItemContentCell
        cell.initItem(content: arrayContent![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = self.contentCollection.frame.width
        let height = width * 1.1
        return CGSize(width: width, height: height)
    }
    
    @objc func addTapped(sender: AnyObject) {
        print("hjxdbsdhjbv")
    }
}
