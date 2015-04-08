//
//  ItemsTableViewController.swift
//  CustomTransitions
//
//  Created by Joyce Echessa on 3/3/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "Item 0\(indexPath.row + 1)"
        return cell
    }
    
    let customPresentAnimationController = CustomPresentAnimationController()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showAction" {
            let toViewController = segue.destinationViewController as UIViewController
            toViewController.transitioningDelegate = self
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentAnimationController
    }
    
    let customDismissAnimationController = CustomDismissAnimationController()
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customDismissAnimationController
    }
    
    let customNavigationAnimationController = CustomNavigationAnimationController()
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .Push {
            customInteractionController.attachToViewController(toVC)
        }
        
        customNavigationAnimationController.reverse = operation == .Pop
        return customNavigationAnimationController
    }
    
    let customInteractionController = CustomInteractionController()
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return customInteractionController.transitionInProgress ? customInteractionController : nil
    }
    

}
