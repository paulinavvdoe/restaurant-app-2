//
//  MenuItemDetailViewController.swift
//  restaurant-app
//
//  Created by Paulina Van der Doe on 14/03/2018.
//  Copyright © 2018 Paulina Van der Doe. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    // Set up delegate variable.
    var delegate: AddToOrderDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToOrderLabel: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var menuItem: MenuItem!

    /// Update screen using function and by calling the delegate function.
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setUpDelegate()
        // Do any additional setup after loading the view.
    }
    
    func setUpDelegate() {
        if let navController = tabBarController?.viewControllers?.last as? UINavigationController,
            let orderTableViewController = navController.viewControllers.first as? OrderTableViewController {
                delegate = orderTableViewController
        }
    }
    
    /// Function to show animation when the order button is tapped.
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        
            // Animation increases the button size and decreases it again in 0.3 seconds.
            UIView.animate(withDuration: 0.3) {
            self.addToOrderLabel.transform =
            CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.addToOrderLabel.transform =
            CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        delegate?.added(menuItem: menuItem)
    }
    
    /// Function to update buttons, labels and image on the user interface screen.
    func updateUI() {
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        descriptionLabel.text = menuItem.description
        addToOrderLabel.layer.cornerRadius = 5.0
        MenuController.shared.fetchImage(url: menuItem.imageURL)
        { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
