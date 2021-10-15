//
//  ViewControllerExtension.swift
//  MirandaMall
//
//  Created by Jorge Miranda on 9/09/20.
//  Copyright © 2020 Jorge Miranda. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func dismissKeyboardOnTap(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
}
