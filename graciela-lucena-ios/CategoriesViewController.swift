//
//  CategoriesViewController.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/25/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD
import CellRegistrable
import SDWebImage

class CategoriesViewController: UIViewController {

    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    private var categories: [String]
    private var selectedCategory : String?

    //MARK: - @IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Initializers
    init(categories: [String]) {
        let nibName = String(self.dynamicType)
        self.categories = categories
        self.categories.insert("All", atIndex: 0)
        super.init(nibName: nibName, bundle: nil)
        title = "Categories"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("categoriesChanges", object: selectedCategory)
    }
        
    private func configureTable() {
        tableView.registerCell(CategoryTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

extension CategoriesViewController : UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        selectedCategory = categories[indexPath.row]
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .None
        selectedCategory = nil
    }
}

extension CategoriesViewController : UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(
            CategoryTableViewCell.reuseIdentifier,
            forIndexPath: indexPath)
        
        if let categoryCell = cell as? CategoryTableViewCell{
            let category = categories[indexPath.row]
            categoryCell.categoryName.text = "✶" + category
        }
        
        return cell
    }
}
