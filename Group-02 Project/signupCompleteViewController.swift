//
//  signupCompleteViewController.swift
//  Group-02 Project
//
//  Created by Chandan  on 11/26/23.
//

import UIKit
import Lottie
import SwiftUI



class signupCompleteViewController: UIViewController {

    
    
    
    @IBOutlet weak var tickk: LottieAnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tickk.animation = .named("checkmark")
        
        tickk.animationSpeed = 1.5
        
        tickk.loopMode = .loop
        tickk.play()

        
    }
    
   
    @IBAction func loginNav(_ sender: UIButton) {
    
        
        
        let vcObj = self.storyboard?.instantiateViewController(withIdentifier: "login")
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.navigationController?.setViewControllers([vcObj!], animated: true)

            

    }

}
