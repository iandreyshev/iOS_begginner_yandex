//
//  ViewController.swift
//  StoryboardPracticle
//
//  Created by Ivan Andreyshev on 25/09/2019.
//  Copyright © 2019 iandreyshev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? NextViewController,
            segue.identifier == "ShowSecondScreen" {
            controller.text = "Hello from previous view controller"
        }
    }

    @IBAction func onOpenButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "ShowSecondScreen", sender: nil)
    }

}

