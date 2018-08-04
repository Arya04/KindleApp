//
//  ViewController.swift
//  KindleApp
//
//  Created by Arya Atighehchian on 7/31/18.
//  Copyright © 2018 Arya Atighehchian. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UITableViewController {
    
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBarStyles()
        setupNavBarButtons()
        
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.lightGray
        
        navigationItem.title = "Kindle"
        
        fetchBooks()
    }
    
    
    func setupNavBarButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu") .withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuPress))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "amazon_icon") .withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAmazonPress))
    }
    @objc func handleMenuPress(){
        print("menu pressed")
    }
    
    @objc func handleAmazonPress(){
        print("amazon pressed")
    }
    
    func setUpNavBarStyles(){
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    
    func fetchBooks() {
        print("Fetching books....")
        if let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if let err = error {
                    print("Failed to fetch external json books: ", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    guard let bookDictionaries = json as? [[String: Any]] else { return }
                    
                    self.books = []
                    for bookDictionary in bookDictionaries {
                        let book = Book(dictionary: bookDictionary)
                        self.books?.append(book)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch let jsonError {
                    print("Failed to parse JSON properly: ", jsonError)
                }
                
            }).resume()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedBook = self.books?[indexPath.row]
        //        print(book?.title)
        //        return
        
        let layout = UICollectionViewFlowLayout()
        let bookPagerController = BookPagerController(collectionViewLayout: layout)
        
        bookPagerController.book = selectedBook
        
        let navController = UINavigationController(rootViewController: bookPagerController)
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
        
        let book = books?[indexPath.row]
        cell.book = book
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = books?.count {
            return count
        }
        return 0
    }
    
    
}


