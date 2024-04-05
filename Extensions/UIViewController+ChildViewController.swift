//
//  UIViewController+ChildViewController.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 05/04/24.
//

import UIKit

fileprivate var currentChildViewControllerKey: UInt8 = 0

extension UIViewController {
    
    var currentChildViewController: UIViewController? {
        get { return objc_getAssociatedObject(self, &currentChildViewControllerKey) as? UIViewController }
        set { objc_setAssociatedObject(self, &currentChildViewControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    func add(childViewController: UIViewController) {
        currentChildViewController = childViewController
        
        addChild(childViewController)
        
        view.addSubview(childViewController.view)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                childViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
                childViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                childViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                childViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        )
        
        childViewController.didMove(toParent: self)
    }
    
    func removeCurrentChildViewController() {
        currentChildViewController?.willMove(toParent: nil)
        
        currentChildViewController?.view.removeFromSuperview()
        
        currentChildViewController?.removeFromParent()
        
        currentChildViewController = nil
    }
    
    func changeCurrentChildViewController(to newChildViewController: UIViewController) {
        if currentChildViewController != nil {
            guard let unwrappedCurrentChildViewController = currentChildViewController,
                  !unwrappedCurrentChildViewController.isKind(of: newChildViewController.classForCoder) else {
                return
            }
        }
        removeCurrentChildViewController()
        add(childViewController: newChildViewController)
    }
}
