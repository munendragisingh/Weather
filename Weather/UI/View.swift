//
//  View.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import UIKit

protocol ViewDelegate: class {
    func view(view: View, didPerformAction action: Any, userInfo: Any?)
}

/// View is the base class of uiview, which have all comune methods
class View: UIView {
    
    weak var delegate: ViewDelegate?
    func viewDidLoad() {
    }
    
    func viewWillAppear() {
    }
    
    func viewDidAppear() {
    }
    
    func viewWillDisappear() {
    }
    
    func viewDidDisappear() {
    }
}

