//
//  MainViewController.swift
//  popoversSizeClasses
//
//  Created by Patrick Pahl on 11/26/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var simpleButton: UIButton?
    @IBOutlet var embeddedButton: UIButton?
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        switch segue.identifier {
        case "SimpleSegue"?:
            let simplePPC = segue.destination.popoverPresentationController
            simplePPC?.delegate = self
            simplePPC?.sourceView = simpleButton
            guard let simpleButtonBounds = simpleButton?.bounds else { return }
            simplePPC?.sourceRect = simpleButtonBounds
            
        case "EmbeddedSegue"?:
            let embeddedPPC = segue.destination.popoverPresentationController
            embeddedPPC?.delegate = self
            embeddedPPC?.sourceView = embeddedButton
            guard let embeddedButtonBounds = embeddedButton?.bounds else { return }
            embeddedPPC?.sourceRect = embeddedButtonBounds
            
        default:
            break
        }
    }
    
}

extension MainViewController: UIPopoverPresentationControllerDelegate{
    
    // In modal presentation we need to add a button to our popover
    // to allow it to be dismissed. Handle the situation where
    // our popover may be embedded in a navigation controller
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        guard style != .none else {
            return controller.presentedViewController
        }
        
        if let navController = controller.presentedViewController as? UINavigationController {
            addDismissButton(navigationController: navController)
            return navController
        } else {
            let navController = UINavigationController.init(rootViewController: controller.presentedViewController)
            addDismissButton(navigationController: navController)
            return navController
        }
    }
    
    // Check for when we present in a non modal style and remove the
    // the dismiss button from the navigation bar.
    
    func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        if style == .none {
            if let navController = presentationController.presentedViewController as? UINavigationController {
                removeDismissButton(navigationController: navController)
            }
        }
    }
    
    func didDismissPresentedView() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func addDismissButton(navigationController: UINavigationController) {
        let rootViewController = navigationController.viewControllers[0]
        rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(MainViewController.didDismissPresentedView))
    }
    
    private func removeDismissButton(navigationController: UINavigationController) {
        let rootViewController = navigationController.viewControllers[0]
        rootViewController.navigationItem.leftBarButtonItem = nil
    }
    
}




