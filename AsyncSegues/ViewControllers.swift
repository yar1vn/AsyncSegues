//
//  Code.swift
//  AsyncSegues
//
//  Created by Yariv Nissim on 2/19/16.
//  Copyright © 2016 Yariv Nissim. All rights reserved.
//

import UIKit

//
// MARK: - View Controllers
//

// MARK: MakesViewController

class MakesViewController: MyTableViewController {
    let makes = [
        Make(name: "Mini", models: [
            Model(name: "Cooper Clubman"),
            Model(name: "Cooper Countryman"),
            Model(name: "Cooper Hardtop"),
            Model(name: "Cooper Hardtop 4 Door"),])
        ,
        Make(name: "Mazda", models: [
            Model(name: "CX-3"),
            Model(name: "CX-5"),
            Model(name: "Mazda3"),
            Model(name: "Mazda6"),
            Model(name: "MX-5 Miata"),])
        ,
        Make(name: "Apple Car", models: [])
    ]
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return makes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let make = makes[indexPath.row]
        
        cell.textLabel?.text = make.name
        cell.detailTextLabel?.text = make.models.isEmpty ? "No models" : "\(make.models.count) models"
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let make = makes[indexPath.row]
        
        showHUD() {
            make.loadModels { models, error in
                self.hideHUD() {
                    guard !make.models.isEmpty else { return }
                    
                    self.performSegueWithIdentifier(.ShowModels, sender: self) { segue, sender in
                        if let vc = segue.destinationViewController as? ModelsContainer {
                            vc.models = models
                        }
                    }
                }
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let make = makes[indexPath.row]
        
        showHUD() {
            make.loadImage { image, error in
                self.hideHUD() {
                    guard let image = image else { return }
                    
                    self.performSegueWithIdentifier(.ShowLogo, sender: indexPath) { segue, sender in
                        if let vc = segue.destinationViewController as? ImageContainer {
                            vc.image = image
                        }
                    }
                }
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension MakesViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case ShowModels = "Show Models"
        case ShowLogo = "Show Logo"
    }
}

// MARK: - ModelsViewController

class ModelsViewController: MyTableViewController, ModelsContainer {
    var models: [Model]? {
        didSet {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = models?[indexPath.row].name ?? "Unknown"
        return cell
    }
}

// MARK: - ImageViewController

class ImageViewController: MyViewController, ImageContainer {
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage? {
        didSet {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.imageView?.image = self.image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}

//
// MARK: - Protocols
//

protocol ModelsContainer: class {
    var models: [Model]? { get set }
}

protocol ImageContainer: class {
    var image: UIImage? { get set }
}

