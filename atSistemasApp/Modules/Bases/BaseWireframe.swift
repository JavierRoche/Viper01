//
//  BaseWireframe.swift
//  atSistemasApp
//
//  Created by APPLE on 11/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation
import UIKit


// MARK: Enums

/// Different transition types to present views
enum TransitionType {
    case navigationBar          // push to navigation controller
    case modal                  // present view
    case modalWithNavigation    // present view with its own novigation controller
}

/// Different Alert types with generic title strings
enum AlertType {
    case information
    case genericError
    
    var title: String {
        switch self {
        case .information:
            return Constants.information
            
        case .genericError:
            return Constants.error
        }
    }
}


// MARK: Class

class BaseWireframe {
    
    /// Launch a Push or Modal Presentation to a Use Case or Any View with Inherance from UIViewController
    ///
    /// - Parameters:
    ///   - view: origin view
    ///   - useCase: destination view
    ///   - withTransition: transition type. Refer to TransitionType enum description
    ///   - modalPresentationStyle: how the modal will be presented
    ///   - animated: Specify true to animate the transition or false if you do not want the transition
    ///     to be animated. You might specify false if you are setting up the navigation controller at launch time.
    ///   - completion: return a Void result on finish presentation
    func presentView(from view: UIViewController?,
                     useCase: UIViewController,
                     withTransition: TransitionType,
                     modalPresentationStyle: UIModalPresentationStyle? = nil,
                     animated: Bool = true,
                     completion: (() -> Void)?) {
        
        switch withTransition {
        
        case .navigationBar:
            view?.navigationController?.pushViewController(useCase, animated: animated)
            
        case .modal:
            if let modalStyle = modalPresentationStyle {
                view?.modalPresentationStyle = modalStyle
            }
            view?.present(useCase, animated: animated, completion: completion)
            
        case .modalWithNavigation:
            let navigation = UINavigationController(rootViewController: useCase)
            if let modalStyle = modalPresentationStyle {
                navigation.modalPresentationStyle = modalStyle
            }
            view?.present(navigation, animated: animated, completion: completion)
        }
    }
    
    /// Dismiss Current View
    ///
    /// - Parameters:
    ///   - originView: current view
    ///   - withTransition: transition type. Refer to TransitionType enum description
    ///   - animated: Specify true to animate the transition or false if you do not want the transition to be
    ///     animated. You might specify false if you are setting up the navigation controller at launch time.
    ///   - completion: return a Void result on finish presentation
    func dismissView(from originView: UIViewController?,
                     withTransition: TransitionType,
                     animated: Bool = true,
                     completion: (() -> Void)?) {
        
        switch withTransition {
        
        case .navigationBar:
            originView?.navigationController?.popViewController(animated: animated)
            
        case .modal:
            originView?.dismiss(animated: animated, completion: completion)
            
        case .modalWithNavigation:
            if originView?.navigationController == nil {
                originView?.dismiss(animated: animated, completion: completion)
            } else {
                originView?.navigationController?.popViewController(animated: animated)
            }
        }
    }
    
    /// Dismiss Navigation Controller to Root View
    ///
    /// - Parameters:
    ///   - originView: current view
    ///   - animated: Specify true to animate the transition or false if you do not want the transition to be
    ///     animated. You might specify false if you are setting up the navigation controller at launch time.
    func dismissToRoot(from originView: UIViewController?, animated: Bool = true) {
        originView?.navigationController?.popToRootViewController(animated: animated)
    }
    
    /// Change Global Root View
    ///
    /// - Parameters:
    ///   - destination: Destination view
    ///   - withNavigationBar: embebs destination view on a navigation bar
    func setAppRootView(_ destination: UIViewController, withNavigationBar: Bool = true) {
        if #available(iOS 13, *) {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                return
            }
            
            // Remove all subviews
            sceneDelegate.window?.subviews.forEach { $0.removeFromSuperview() }
            
            if withNavigationBar {
                sceneDelegate.window?.rootViewController = UINavigationController.init(rootViewController: destination)
            } else {
                sceneDelegate.window?.rootViewController = destination
            }
        }
    }
    
    /// Show a Customizable Modal Alert
    ///
    /// - Parameters:
    ///   - view: current view
    ///   - title: alert title text
    ///   - content: alert content text
    ///   - customActions: customActions, if this parameter is empty, by default is added a lozalicable accept button
    ///   - completion: return a Void result on finish presentation
    func showCustomModalAlert(_ view: UIViewController?,
                              title: String,
                              content: String,
                              customActions: [UIAlertAction]? = nil,
                              completion: (() -> Void)?) {
        
        let basicAlert = UIAlertController.init(title: title, message: content, preferredStyle: .alert)
        
        if let wrappedActions = customActions {
            wrappedActions.forEach({
                basicAlert.addAction($0)
            })
        }
        self.presentView(from: view, useCase: basicAlert, withTransition: .modal, completion: completion)
    }
    
    /// Show a Simple Error Alert, Title of this Alert is a Lozalizable message "Error"
    ///
    /// - Parameters:
    ///   - view: current view
    ///   - content: content title text
    ///   - customActions: array of custom Actions. If this parameter is empty,
    ///                 by default is added a lozalicable "Accept" button
    ///   - completion: return a Void result on finish presentation
    func showErrorModalAlert(_ view: UIViewController?,
                             content: String,
                             customActions: [UIAlertAction]? = nil,
                             completion: (() -> Void)?) {
        
        let basicErrorAlert = UIAlertController.init(title: AlertType.genericError.title,
                                                     message: content,
                                                     preferredStyle: .alert)
        if let wrappedActions = customActions {
            wrappedActions.forEach({
                basicErrorAlert.addAction($0)
            })
        }
        self.presentView(from: view, useCase: basicErrorAlert, withTransition: .modal, completion: completion)
    }
}
