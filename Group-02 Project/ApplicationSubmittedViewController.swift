//
//  ApplicationSubmittedViewController.swift
//  Group-02 Project
//
//  Created by Chandan  on 11/26/23.
//

import UIKit
import Lottie
import FirebaseAuth
import FirebaseDatabaseInternal


class ApplicationSubmittedViewController: UIViewController {
    
    var name = ""
    var email = ""
    var job: [Job]?
    var jobtitle: String?
    
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var maill: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = Auth.auth().currentUser {
            email = currentUser.email ?? "N/A"
            
            // Use the email to retrieve the username from the database
            let emailDatabase = email.replacingOccurrences(of: ".", with: ",")
            let userRef = Database.database().reference().child("Users").child(emailDatabase)
            
            userRef.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
                guard let self = self else { return }
                
                if snapshot.exists() {
                    if let userData = snapshot.value as? [String: Any],
                       let firstname = userData["firstName"] as? String,
                       let lastname = userData["lastName"] as? String,
                       let dob = userData["dob"] as? String {
                        
                        // Display the username in the NameLabel
                        self.name = "\(firstname) \(lastname)"
                        
                        DispatchQueue.main.async {
                            self.updateUI()
                        }
                    } else {
                        print("Error: Unable to parse user data")
                    }
                } else {
                    print("Error: User does not exist in the database")
                    print(self.email)
                }
            }) { (error) in
                print("Error fetching user data: \(error.localizedDescription)")
            }
        } else {
            print("No user is currently logged in.")
        }
        
        maill.animation = .named("received")
        maill.animationSpeed = 0.5
        maill.loopMode = .loop
        maill.play()
        
        // Update UI here (remove from viewDidLoad)
        updateUI()
    }
    
    func updateUI() {
        greetingsLabel.text = "Greetings \(self.name),\nWe are currently reviewing your application for position of \(String(describing: jobtitle ?? "")) and will get back to you soon !!!\nWe will mail you on \(email)."
    }
    
    @IBAction func NavHome(_ sender: UIButton) {
        let vcObj = self.storyboard?.instantiateViewController(withIdentifier: "home")
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.setViewControllers([vcObj!], animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let transition = segue.identifier
        
        if transition == "startSegue" {
            let destination = segue.destination as! HomeViewController
            destination.username = name
            destination.email = email
        }
    }
}
