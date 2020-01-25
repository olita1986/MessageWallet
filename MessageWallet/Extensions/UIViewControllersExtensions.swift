//
//  UIViewControllersExtensions.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import UIKit

extension UIViewController {
    func addDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc
    private func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
