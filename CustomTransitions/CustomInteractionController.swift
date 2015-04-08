//
//  CustomInteractionController.swift
//  CustomTransitions
//
//  Created by luojie on 4/7/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class CustomInteractionController: UIPercentDrivenInteractiveTransition {
    
    var navigationController: UINavigationController!
    var shouldCompleteTransition = false
    var transitionInProgress = false
    var completionSeed: CGFloat {
        return 1 - percentComplete
    }
    
    func attachToViewController(viewController: UIViewController) {
        navigationController = viewController.navigationController
        setupGestureRecognizer(viewController.view)
    }
   
    private func setupGestureRecognizer(view: UIView) {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "handlePanGesture:"))
        
    }
    
    
    func handlePanGesture(gestrueRecognizer: UIPanGestureRecognizer) {
        let viewTranslation = gestrueRecognizer.translationInView(gestrueRecognizer.view!.superview!)
        switch gestrueRecognizer.state {
        case .Began:
            transitionInProgress = true
            navigationController.popViewControllerAnimated(true)
        case .Changed:
            var const = CGFloat(fminf(fmaxf(Float(viewTranslation.x / 200.0), 0.0), 1.0))
            shouldCompleteTransition = const > 0.5
            updateInteractiveTransition(const)
        case .Cancelled, .Ended:
            transitionInProgress = false
            if !shouldCompleteTransition || gestrueRecognizer.state == .Cancelled {
                cancelInteractiveTransition()
            }else{
                finishInteractiveTransition()
            }
            
        default:
            println("Swift switch must be exhaustive, thus the defult")
            
        }
    }
}
