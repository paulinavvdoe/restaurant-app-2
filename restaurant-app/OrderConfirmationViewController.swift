//
//  OrderConfirmationViewController.swift
//  restaurant-app
//
//  Created by Paulina Van der Doe on 15/03/2018.
//  Copyright © 2018 Paulina Van der Doe. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    

    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes."
    }
    
}
