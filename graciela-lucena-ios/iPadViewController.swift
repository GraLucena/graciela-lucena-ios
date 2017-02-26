//
//  iPadViewController.swift
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

protocol iPadCoodinator: class{
    func userDidPressShowAppDetail(app: Entry)
    func userDidPressShowCategories(categories: [String])
}

class iPadViewController: UIViewController {

    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    private var apps: [Entry]
    private let reachabilityManager = NetworkReachabilityManager(host: Router.reachabilityPath)

    weak var coordinator: iPadCoodinator?

    //MARK: - @IBOutlets
    @IBOutlet var collectionView: UICollectionView!
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getApps()
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
        
        collectionView.reloadData()
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
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
    }
    
    func refreshApps() {
        title = "Top Apps"
        getApps()
        self.refreshControl.endRefreshing()
    }

    private func configureCollectionView() {
        collectionView.registerCell(AppCollectionViewCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func getApps(){
        SVProgressHUD.show()
        AppsAPI.readApps()
            .doOnNext { [weak self] (apps) in
                SVProgressHUD.dismiss()
                self?.apps = apps
                self?.configureCollectionView()
                self?.collectionView.reloadData()
            }
            .subscribe()
            .addDisposableTo(disposeBag)
    }
    
    //MARK: - Animation -> http://stackoverflow.com/questions/36282996/how-i-could-make-this-animation-in-a-uicollectionviewcell-when-tapped - Miguel Perez(Answer)
    
    func processVisibleItems(){
        let visibleItems = self.collectionView?.indexPathsForVisibleItems()
        for p in visibleItems! as [NSIndexPath]{
            // create a layer which will contain the cell for each of the visibleItems
            let containerLayer = CALayer()
            containerLayer.frame = (self.collectionView?.layer.bounds)!
            containerLayer.backgroundColor = UIColor.clearColor().CGColor
            
            // we need to change the anchor point which will offset the layer - adjust accordingly
            var containerFrame:CGRect! = containerLayer.frame
            containerFrame.origin.x -= containerLayer.frame.size.width/2
            containerLayer.frame = containerFrame
            containerLayer.anchorPoint = CGPointMake(0.0, 0.5)
            self.collectionView?.layer.addSublayer(containerLayer)
            
            //add the cell to the new layer
            let cell = self.collectionView?.cellForItemAtIndexPath(p) as! AppCollectionViewCell
            cell.frame = containerLayer .convertRect(cell.frame, fromLayer: cell.superview!.layer)
            containerLayer.addSublayer(cell.layer)
            addAnimationForLayer(containerLayer)
        }
    }
    
    func addAnimationForLayer(layerToAnimate: CALayer){
        // fade-out animation
        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.toValue = 0.0
        
        //rotation Animation
        let rotationAnimation = CABasicAnimation(keyPath: "transform")
        var tfm = CATransform3D()
        tfm = CATransform3DMakeRotation((65.0 * CGFloat(M_PI) )/180.0, 0.0, -1.0, 0.0)
        tfm.m14 = -0.002
        rotationAnimation.fromValue = NSValue(CATransform3D:CATransform3DIdentity)
        rotationAnimation.toValue = NSValue(CATransform3D:tfm)
        
        //group the animations and add to the new layer
        let group = CAAnimationGroup()
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        group.fillMode = kCAFillModeForwards
        group.removedOnCompletion = false
        group.duration = 0.35
        group.animations = [rotationAnimation,fadeOutAnimation]
        layerToAnimate.addAnimation(group, forKey: "rotateAndFadeAnimation")
    }
}

//MARK: - UICollectionViewDelegate
extension iPadViewController : UICollectionViewDelegate{

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        processVisibleItems()
        let app = apps[indexPath.row]
        coordinator?.userDidPressShowAppDetail(app)
    }
}

//MARK: - UICollectionViewDataSource
extension iPadViewController : UICollectionViewDataSource{
        
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(AppCollectionViewCell.reuseIdentifier, forIndexPath: indexPath)
        
        if let appCell = cell as? AppCollectionViewCell{
            let app = apps[indexPath.row]
            
            if let image = app.image.first?.imageURL{
                appCell.appImage.sd_setImageWithURL(NSURL(string: image))
            }
        }
        return cell
    }
}