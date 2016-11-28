//
//  MainViewController.swift
//  popoversSizeClasses
//
//  Created by Patrick Pahl on 11/26/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // **When creating Segues: Present as Popover

    @IBOutlet var simpleButton: UIButton?
    @IBOutlet var embeddedButton: UIButton?
    
    // MARK: - Navigation
    
    //We set the popover presentation controller (PPC) and popover anchor point in the prepForSegue
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
    
    // If we are about to present with a non modal style we check for a navigation controller and if present remove the done button.
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        guard style != .none else {
            return controller.presentedViewController
        }
        //Since our presented view controller may or may not already be embedded in a navigation controller we handle both cases.
        if let navController = controller.presentedViewController as? UINavigationController {
            addDismissButton(navigationController: navController)
            return navController
        } else {
            let navController = UINavigationController.init(rootViewController: controller.presentedViewController)
            addDismissButton(navigationController: navController)
            return navController
        }
    }
    
    // Check for when we present in a non modal style and remove the dismiss button from the navigation bar.
    func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        if style == .none {
            if let navController = presentationController.presentedViewController as? UINavigationController {
                removeDismissButton(navigationController: navController)
            }
        }
    }
    
    // If the presented view controller is a navigation controller (which it is for the second segue) we add the button and return it. Otherwise we embed it as the root of a new navigation controller
    // *Note that we add the button to the root view controller which is navigationController.viewControllers[0] and not navigationController.topViewController which might be the detail view controller when the transition happens.
    private func addDismissButton(navigationController: UINavigationController) {
        let rootViewController = navigationController.viewControllers[0]
        rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(MainViewController.didDismissPresentedView))
    }
    
    //We need the function that dismisses the presented view controller when the user taps the done button
    func didDismissPresentedView() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func removeDismissButton(navigationController: UINavigationController) {
        let rootViewController = navigationController.viewControllers[0]
        rootViewController.navigationItem.leftBarButtonItem = nil
    }
    
}




