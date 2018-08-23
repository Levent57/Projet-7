//
//  UIViewController.swift
//  CountOnMe
//
//  Created by Levent Bostanci on 20/07/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //parameter message: String the message you wan to display
    func showErrorPopup(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
