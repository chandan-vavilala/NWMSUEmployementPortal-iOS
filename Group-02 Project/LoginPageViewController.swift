//
//  ViewController.swift
//  Group-02 Project
//
//  Created by Chandan  on 11/21/23.
//

import UIKit
import Firebase
import Lottie

class LoginPageViewController: UIViewController {
    
    let databaseRef = Database.database().reference()
    
    
    var username:String?
    var isanime = true
    
    
    @IBOutlet weak var emailOL: UITextField!
    
    
    @IBOutlet weak var passwordOL: UITextField!
    
    @IBOutlet weak var initialOL: LottieAnimationView! {
        didSet{
            if self.isanime{
            self.initialOL.animation = .named("study")
            self.initialOL.loopMode = .playOnce
                self.initialOL.play{[weak self] _ in
                    UIViewPropertyAnimator.runningPropertyAnimator(
                        withDuration: 1.0,
                        delay: 0.0,
                        options: [.curveEaseInOut]){
                            self!.animationn = ""
                            self?.initialOL.alpha = 0.0
                            
                        }
                }
                
            }
        }
    }
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    @IBOutlet weak var loadingAnime: LottieAnimationView!
    
    var animationn = "study"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        initialOL.animation = .named(animationn)
//        initialOL.loopMode = .playOnce
//        initialOL.play{[weak self] _ in
//                            UIViewPropertyAnimator.runningPropertyAnimator(
//                                withDuration: 1.0,
//                                delay: 0.0,
//                                options: [.curveEaseInOut]){
//                                    self!.animationn = ""
//                                    self?.initialOL.alpha = 0.0
//                                    
//                                }
//                            
//                        }
        loadingAnime.isHidden = true
    }
    
   
 

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Adjust the view's frame to move it above the keyboard
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        // Reset the view's frame to its original position
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    
    @IBAction func loginActn(_ sender: Any) {
        
        loadingAnime.isHidden = false
        errorLabel.isHidden = true
        loadingAnime.animation = .named("loading")
        
        loadingAnime.play()
        
        
//        
//        guard let email=emailOL.text else {return}
//        guard let password=passwordOL.text else{return}
//        
//        
//        Auth.auth().signIn(withEmail: email, password: password){ firebaseResult,error in
//            
//            if error != nil{
//                print("error")
//                self.loadingAnime.isHidden = true
//                
//                self.errorLabel.isHidden = false
//                self.errorLabel.text = "Enter Correct User Name or Password"
//                self.emailOL.text = ""
//                self.passwordOL.text = ""
//                
//            }
//            
//            else {
//                        let emailForDatabase = email.replacingOccurrences(of: ".", with: ",")
//                
//                        let userRef = self.databaseRef.child("Users").child(emailForDatabase)
//                        print("1")
//                        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
//                            if snapshot.exists() {
//                                if
//                                    let userData = snapshot.value as? [String: Any],
//                                   let firstName = userData["firstName"] as? String,
//                                   let lastName = userData["lastName"] as? String 
//                                {
//                                    
//                                    print("Username: \(firstName)\(lastName)")
//                                    let username = "\(firstName) \(lastName)"
//                                    
//                                    
//                                 //  self.performSegue(withIdentifier: "employementSegue", sender: username)
//                                    
//                                    
                                    let vcObj = self.storyboard?.instantiateViewController(withIdentifier: "home")
                                    
                                    self.navigationController?.navigationBar.prefersLargeTitles = false
                                    
                                    self.navigationController?.setViewControllers([vcObj!], animated: true)
//                                    
//                                    
//                                } else {
//                                    print("Error: Unable to parse user data")
//                                }
//                            } else {
//                                print("Error: User does not exist in the database")
//                                print(emailForDatabase)
//                            }
//                }) { (error) in
//                    print("Error fetching user data: \(error.localizedDescription)")
//                }
//                
//

//            }
            
            
//        }

        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        errorLabel.text = ""
        loadingAnime.isHidden = true
        if let destination = segue.destination as? HomeViewController,
           let username = sender as? String {
            destination.username = username
            destination.email = emailOL.text
        }
    }
    
    
    @IBAction func sigunUp(_ sender: Any) {
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }
}
