//
//  NearByController.swift
//  PDAInClassApp
//
//  Created by joseph nelson on 2018-04-30.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import Firebase

final class NearByController: UIViewController {
    //MARK: Properties
    fileprivate var profiles = [Profile]()
    
    
    //MARK: IBOutlets
    @IBOutlet fileprivate var collectionView: UICollectionView!
    
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        
    }
    
    //MARK: Loading
    fileprivate func load() {
        Database.database().reference().child("Users").observeSingleEvent(of: .value) { shapshot in
            var profiles = [Profile]()
            for child in shapshot.children {
                guard
                    let child = child as? DataSnapshot,
                    let profile = Profile(snapshot: child)
                    else { continue }
                profiles.append(profile)
            }
            self.profiles = profiles
            self.collectionView.reloadData()
        }
    }
}

//MARK: -
extension NearByController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearbyCell", for: indexPath) as! NearbyCell
        // set the profile
        let profile = profiles[indexPath.row]
        // get the profile data
        cell.setData(profile: profile)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = UIScreen.main.bounds.width/3 - 20
        let size = CGSize(width: dimension, height: dimension+20)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProfilePreviewController", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()!
        navigationController?.pushViewController(controller, animated: true)
        
      
    }
}
