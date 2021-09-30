//
//  ViewController.swift
//  ClockTest
//
//  Created by Yunus Abubakarov on 28.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clockView: ClockView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.clockView.setNeedsDisplay()
        }
    }
}

