//
//  HomeVC.swift
//  Ionix App
//
//  Created by Francisco Landa Torres on 04/08/21.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {
    @IBOutlet var contentCollection: UICollectionView!
    @IBOutlet var viewContent: UIView!
    @IBOutlet var viewError: UIView!
    
    private var searchController : UISearchController?
    private var arrayContent: [ContentEntity]?
    private var arrayContentBackup: [ContentEntity]?
    private var alert: UIAlertController?
    private var loaderView : LoaderVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewController()
        // Do any additional setup after loading the view.
    }
    
    private func initViewController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "engine"), style: .plain, target: self, action: #selector(addTapped))
        
        arrayContent = [ContentEntity]()
        arrayContentBackup = [ContentEntity]()
        
        arrayContent = arrayContentBackup
        
        self.contentCollection.dataSource = self
        self.contentCollection.delegate = self
        self.contentCollection.register(UINib(nibName: "ItemContentCell", bundle: nil), forCellWithReuseIdentifier: "itemContentCell")
        
        if (UserDefaults.standard.value(forKey: "firstTime") == nil) {
            MainRouter.sharedWith(navigation: self.navigationController!).goCarouselPermission()
            UserDefaults.standard.setValue(true, forKey: "firstTime")
        }else{
            getMemes()
        }
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
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContent(param: searchBar.text!)
    }
    
    func filterContent(param: String){
        if param == "" {
            arrayContent = arrayContentBackup
        }else{
            arrayContent = arrayContentBackup!.filter {
                $0.title!.lowercased().contains(param.lowercased())
            }
        }
        
        if arrayContent?.count == 0 {
            viewError.isHidden = false
            viewContent.isHidden = true
        }else{
            viewError.isHidden = true
            viewContent.isHidden = false
            contentCollection.reloadData()
        }
    }
    
    @objc func addTapped(sender: AnyObject) {
        MainRouter.sharedWith(navigation: self.navigationController!).goCarouselPermission()
    }
    
    private func getMemes(){
        if loaderView == nil {
            loaderView = LoaderVC(nibName: "LoaderVC", bundle: nil)
        }
        present(loaderView!, animated: true, completion: nil)
        ServicesManager.shared.getListMemes(limit: 100, whenFinish: { (status, response, error) in
            DispatchQueue.main.async {
                if status {
                    self.loaderView!.dismiss(animated: true, completion: nil)
                    self.arrayContentBackup = response as? [ContentEntity]
                    self.arrayContent = self.arrayContentBackup
                    self.contentCollection.reloadData()
                }else{
                    
                }
            }
            
        })
    }
    
}
