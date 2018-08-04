//
//  BookPagerController.swift
//  KindleApp
//
//  Created by Arya Atighehchian on 8/3/18.
//  Copyright © 2018 Arya Atighehchian. All rights reserved.
//

import Foundation
import UIKit

class BookPagerController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        
        collectionView?.isPagingEnabled = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector (handleCloseBook))
        layout?.minimumLineSpacing = 0
        
        navigationItem.title = self.book?.title
    }
    
    @objc func handleCloseBook() {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.height-64))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book?.pages.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let page = book?.pages[indexPath.item]
        cell.textLabel.text = page?.text
        
        return cell
    }
    
}
