//
//  UIViewControllerExt.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func segueToAppllication() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabViewController = storyBoard.instantiateViewController(withIdentifier: "mainTabVC") as! UITabBarController
        appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
        appDelegate.window?.rootViewController = mainTabViewController
    }
    
    func segueToStartScreen() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let startController = storyBoard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
        appDelegate.window?.rootViewController = startController
    }
    
}
