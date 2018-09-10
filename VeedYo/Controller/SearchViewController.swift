//
//  SearchViewController.swift
//  VeedYo
//
//  Created by Sidhant Chadha on 9/6/18.
//  Copyright © 2018 AMoDynamics, Inc. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseAuth
import Hero


class SearchViewController: UIViewController, UISearchBarDelegate {
    
    //GOOGLE API KEY: AIzaSyDv35psThNIdKtxJ7spexpV0ACW0hWfn9M
    var globalDecodedJSON : MRData?
    var videoArray = [Item]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func logOutButtonPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("User signed out")
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SVProgressHUD.show()
        videoArray.removeAll()
        let searchString = searchBar.text
        if (searchString?.isEmpty)!{
            return
        }
        
        if !(searchString?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            let parsedQueryString = searchString?.replacingOccurrences(of: " ", with: "+")
            connectionManager(searchQuery: parsedQueryString!)
        }
        collectionView.reloadData()
        SVProgressHUD.dismiss()
        self.searchBar.endEditing(true)
        
        
    }
    
    func connectionManager(searchQuery : String) {
        
        let stringURL="https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(searchQuery)&type=video&key=AIzaSyDv35psThNIdKtxJ7spexpV0ACW0hWfn9M&maxResults=50"
        let url=URL.init(string: stringURL)
        
        do {
            let data = try Data.init(contentsOf: url!)
            globalDecodedJSON = try JSONDecoder().decode(MRData.self, from: data)
            print("Decoding JSON object success.")
            for index in 0..<50 {
                videoArray.append((globalDecodedJSON?.items[index])!)
            }
            
        }
            
        catch  {
            print("Decoding JSON object failed.")
        }
    }
}

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let video = videoArray[indexPath.row].snippet
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideoResultCell
        cell.setVideo(video : video)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = videoArray[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.hero.id = "abc"
        cell?.hero.modifiers = [.spring(stiffness: 250, damping: 25)]

        performSegue(withIdentifier: "goToVideo", sender: video)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToVideo" {
            let destVC = segue.destination as! PlaybackViewController
            destVC.video = sender as? Item
          

        }
        
    
    }
    
    
}

