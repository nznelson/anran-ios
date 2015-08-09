//
//  UIViewControllerExtension.swift
//  Anram
//
//  Created by Nelson Shaw on 8/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import UIKit

extension UIViewController { // Remote Loading heloer
    func addLoadingView() -> UIActivityIndicatorView {
        view.userInteractionEnabled = false
        
        let aV = UIActivityIndicatorView()
        aV.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        aV.center = view.center
        aV.startAnimating()
        aV.color = UIColor.grayColor()
        
        return aV
    }
    
    func addSpinnerAndStall() -> UIActivityIndicatorView {
        let spinner = addLoadingView()
        self.view.addSubview(spinner)
        
        self.view.userInteractionEnabled = false
        
        return spinner
    }
    
    func bringAliveAndRemove(spinner: UIActivityIndicatorView) {
        spinner.removeFromSuperview()
        self.view.userInteractionEnabled = true
    }
}