//
//  AppDetailViewController.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/25/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

class AppDetailViewController: UIViewController {

    //MARK: - Properties
    private var app: Entry

    //MARK: - @IBOutlets
    @IBOutlet var scroll: UIScrollView!
    @IBOutlet var appImage: UIImageView!
    @IBOutlet var appName: UILabel!
    @IBOutlet var appRights: UILabel!
    @IBOutlet var getBttn: UIButton!
    @IBOutlet var appCategory: UILabel!
    @IBOutlet var appReleaseDate: UILabel!
    @IBOutlet var appSummary: UILabel!
    
    // MARK: - Initializers
    init(app: Entry) {
        let nibName = String(self.dynamicType)
        self.app = app
        super.init(nibName: nibName, bundle: nil)
        title = app.name.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }

    // MARK: - Utils
    private func configureView() {
        if let image = app.image.last?.imageURL{
            appImage.sd_setImageWithURL(NSURL(string: image))
        }
        appImage.layer.cornerRadius = 10
        appImage.clipsToBounds = true
        appImage.layer.borderWidth = 1.0
        appImage.layer.borderColor = UIColor.lightGrayColor().CGColor

        appName.text = app.name.name
        appRights.text = app.rights.rights
        getBttn.setTitle(app.price.label.uppercaseString, forState: .Normal)
        getBttn.layer.cornerRadius = 5
        getBttn.layer.borderWidth = 1
        getBttn.layer.borderColor = Color.blue.color.CGColor
        appCategory.text = app.category.attributes.label
        appReleaseDate.text = app.releaseDate.attributes.label
        appSummary.text = app.summary.summary
    }

}
