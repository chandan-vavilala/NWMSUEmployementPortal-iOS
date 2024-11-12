//
//  LaunchViewController.swift
//  Group-02 Project
//
//  Created by Chandan  on 11/27/23.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var loadingterm: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        loadingterm.animation = .named("loading")
        
        loadingterm.play()
        
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
