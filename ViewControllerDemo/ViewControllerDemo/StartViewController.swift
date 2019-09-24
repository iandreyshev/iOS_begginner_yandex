//
//  StartViewController.swift
//  ViewControllerDemo
//
//  Created by Ivan Andreyshev on 24/09/2019.
//  Copyright © 2019 iandreyshev. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBAction func onShowSecondViewControllerClick(_ sender: Any) {
        let secondViewController = SecondViewController()
        navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Start"
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
