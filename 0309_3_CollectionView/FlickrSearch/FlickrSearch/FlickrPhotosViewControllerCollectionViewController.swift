//
//  FlickrPhotosViewControllerCollectionViewController.swift
//  FlickrSearch
//
//  Created by Hamza on 09/09/16.
//  Copyright © 2016 Hamza. All rights reserved.
//

import UIKit

final class FlickrPhotosViewControllerCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    private let reuseIdentifier = "FlickrCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private var searches = [FlickrSearchResults]()
    private let flickr = Flickr()
    private let itemsPerRow: CGFloat = 3
}

// MARK: Private
private extension FlickrPhotosViewControllerCollectionViewController {
    func photoForIndexPath(indexPath: NSIndexPath) -> FlickrPhoto {
        return searches[indexPath.section].searchResults[indexPath.row]
    }
}

extension FlickrPhotosViewControllerCollectionViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // 1
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        flickr.searchFlickrForTerm(textField.text!) {
            results, error in
            
            activityIndicator.removeFromSuperview()
            
            if let error = error {
                // 2
                print("Error searching : \(error)")
                return
            }
            
            if let results = results {
                // 3 
                print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                self.searches.insert(results, atIndex: 0)
                
                // 4
                self.collectionView?.reloadData()
            }
         }
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}

// MARK: UICollectionViewDataSource

extension FlickrPhotosViewControllerCollectionViewController {
    // 1
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return searches.count
    }
    
    // 2
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }
    
    // 3
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FlickrPhotoCellCollectionViewCell
        
        // 2
        let flickrPhoto = photoForIndexPath(indexPath)
        
        // 3
        cell.imageView.image = flickrPhoto.thumbnail
        
        // Configure the cell
        return cell
    }
}

extension FlickrPhotosViewControllerCollectionViewController : UICollectionViewDelegateFlowLayout {
    // 1
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // 3
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return sectionInsets.left
    }
}





