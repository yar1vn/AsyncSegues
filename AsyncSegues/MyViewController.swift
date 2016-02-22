//
//  MyViewController.swift
//  AsyncSegues
//
//  Created by Yariv Nissim on 2/19/16.
//  Copyright © 2016 Yariv Nissim. All rights reserved.
//

import UIKit

public class MyViewController: UIViewController {
    private var prepareBlock: ((segue: UIStoryboardSegue, sender: AnyObject?) -> Void)?
    
    // Block based `prepareForSegue`
    // Note: Must call super when overridden to preserve this functionality
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let prepareBlock = prepareBlock {
            prepareBlock(segue: segue, sender: sender)
            self.prepareBlock = nil
            return
        }
    }
    
    // MARK: HUD
    
    public func showHUD(completion: (() -> Void)? = nil) {
        let hudVC = storyboard!.instantiateViewControllerWithIdentifier("HUD")
        presentViewController(hudVC, animated: true, completion: completion)
    }
    
    public func hideHUD(completion: (() -> Void)? = nil) {
        dismissViewControllerAnimated(true, completion: completion)
    }
}

public extension SegueHandlerType where Self: MyViewController, SegueIdentifier.RawValue == String {
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier, sender: AnyObject?, prepareBlock: ((segue: UIStoryboardSegue, sender: AnyObject?) -> Void)?) {
        
        self.prepareBlock = prepareBlock
        performSegueWithIdentifier(segueIdentifier, sender: sender)
    }
}

//
// Everything has to be duplicated for UITableViewController :~(
//

public class MyTableViewController: UITableViewController {
    private var prepareBlock: ((segue: UIStoryboardSegue, sender: AnyObject?) -> Void)?
    
    // Block based `prepareForSegue`
    // Note: Must call super when overridden to preserve this functionality
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let prepareBlock = prepareBlock {
            prepareBlock(segue: segue, sender: sender)
            self.prepareBlock = nil
            return
        }
    }
    
    // MARK: HUD
    
    public func showHUD(completion: (() -> Void)? = nil) {
        let hudVC = storyboard!.instantiateViewControllerWithIdentifier("HUD")
        presentViewController(hudVC, animated: true, completion: completion)
    }
    
    public func hideHUD(completion: (() -> Void)? = nil) {
        dismissViewControllerAnimated(true, completion: completion)
    }
}

public extension SegueHandlerType where Self: MyTableViewController, SegueIdentifier.RawValue == String {
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier, sender: AnyObject?, prepareBlock: ((segue: UIStoryboardSegue, sender: AnyObject?) -> Void)?) {
        
        self.prepareBlock = prepareBlock
        performSegueWithIdentifier(segueIdentifier, sender: sender)
    }
}
