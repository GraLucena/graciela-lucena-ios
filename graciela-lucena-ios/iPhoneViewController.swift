//
//  iPhoneViewController.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD
import CellRegistrable
import SDWebImage
import Alamofire

protocol iPhoneCoodinator: class{
    func userDidPressShowAppDetail(app: Entry)
    func userDidPressShowCategories(categories: [String])
}

class iPhoneViewController: UIViewController {
    
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private let reachabilityManager = NetworkReachabilityManager(host: Router.reachabilityPath)
    private let refreshControl = UIRefreshControl()
    private var apps: [Entry]
    
    weak var coordinator: iPhoneCoodinator?

    //MARK: - @IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Initializers
    init() {
        let nibName = String(self.dynamicType)
        apps = [Entry]()
        super.init(nibName: nibName, bundle: nil)
        title = "Top Apps"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getApps()
        setupRefreshController()
        setupNavButtons()
        reachabilityManager?.startListening()
        
        //Notify when user change Category
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(categoriesChanges),
            name: "categoriesChanges",
            object: nil)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Utils
    func categoriesChanges(notification: NSNotification) {
        
        if let selectedCategory = notification.object as? String{
            
            if selectedCategory == "All" {
                title = "Top Apps"
                getApps()
            }else{
                title = selectedCategory
                apps = apps.filter({(app) in app.category.attributes.label == selectedCategory})
            }
        }
        tableView.reloadData()
    }
    
    private func setupNavButtons() {
        let categories = UIBarButtonItem(title:"Categories", style: .Plain, target: self, action: #selector(didPressShowCategories))
        navigationItem.leftBarButtonItem = categories
        let noInternet = UIBarButtonItem(image: UIImage(named: "ic_noSignal"), style: .Plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = noInternet

        reachabilityManager?.listener = { status in
            
            switch status {
            case .Reachable(_):
                self.navigationItem.rightBarButtonItem = nil
            default:
                break
            }
        }
    }
    
    func didPressShowCategories(){
        coordinator?.userDidPressShowCategories(AppsAPI.getCategories())
    }
    
    private func setupRefreshController() {
        refreshControl.tintColor = Color.blue.color
        refreshControl.addTarget(self, action: #selector(refreshApps), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        tableView.alwaysBounceVertical = true
    }
    
    func refreshApps() {
        title = "Top Apps"
        getApps()
        self.refreshControl.endRefreshing()
    }
    
    private func configureTable() {
        tableView.registerCell(AppTableViewCell)
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    private func getApps(){
        SVProgressHUD.show()
        AppsAPI.readApps()
            .doOnNext { [weak self] (apps) in
                SVProgressHUD.dismiss()
                self?.apps = apps
                self?.configureTable()
                self?.tableView.reloadData()
            }
            .subscribe()
            .addDisposableTo(disposeBag)
    }
}

extension iPhoneViewController : UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let app = apps[indexPath.row]
        coordinator?.userDidPressShowAppDetail(app)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
         let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransform
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            cell.layer.transform = CATransform3DIdentity
        })
    }
}

extension iPhoneViewController : UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(
            AppTableViewCell.reuseIdentifier,
            forIndexPath: indexPath)
        
        if let appCell = cell as? AppTableViewCell{
            let app = apps[indexPath.row]

            appCell.name.text = app.name.name
            appCell.category.text = app.category.attributes.label
            if let image = app.image.first?.imageURL{
                appCell.appImage.sd_setImageWithURL(NSURL(string: image))
            }
        }
        return cell
    }
}
