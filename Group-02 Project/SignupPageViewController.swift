//
//  SignupPageViewController.swift
//  Group-02 Project
//
//  Created by Chandan  on 11/25/23.
//



import UIKit
import Firebase
import Lottie

class SignupPageViewController: UIViewController {
    
    @IBOutlet weak var firstNameOL: UITextField!
    @IBOutlet weak var lastnameOL: UITextField!
    @IBOutlet weak var emailOL: UITextField!
    @IBOutlet weak var passwordOL: UITextField!
    @IBOutlet weak var rePasswordOL: UITextField!
    @IBOutlet weak var DOBOL: UIDatePicker!
    @IBOutlet weak var errorLabel: UILabel!

    
    @IBOutlet weak var loadingOL: LottieAnimationView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        loadingOL.animation = .named("loading")
        
        loadingOL.play()
        


        
        var dob = DOBOL.date
        
        let dateFormatter = DateFormatter()
        
        
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm"
        
        dateFormatter.timeZone = TimeZone(identifier: "America/Chicago")
        
    
        
        guard let email = emailOL.text,
              let password = passwordOL.text,
              let confirmPassword = rePasswordOL.text,
              let firstName = firstNameOL.text,
              let lastName = lastnameOL.text
              else { return }

        guard password == confirmPassword else {
                errorLabel.text = "Passwords do not match."
                loadingOL.stop()
                loadingOL.isHidden = true
                return
            }
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.loadingOL.animation = .named("")
                print("Error creating user: \(error.localizedDescription)")
                self.errorLabel.text = "\(error.localizedDescription)"
            } else if let user = authResult?.user {
                self.storeUserDetails(email: email, firstName: firstName, lastName: lastName, dob: dob.description
                    )
                print(dob)
                self.performSegue(withIdentifier: "signUpCompleteSegue", sender: self)
            }
        }
    }


    func storeUserDetails(email: String, firstName: String, lastName: String, dob: String) {
        let databaseRef = Database.database().reference()
        let usersRef = databaseRef.child("Users")
        let userRef = usersRef.child(email.replacingOccurrences(of: ".", with: ","))
        

        let userDetails = [
            "firstName": firstName,
            "lastName": lastName,
            "dob": dob
            
            // Add more fields as needed
        ]
        

        userRef.setValue(userDetails) { (error, _) in
            if let error = error {
                print("Error storing user details: \(error.localizedDescription)")
            } else {
                print("User details stored successfully")
            }
        }
    }
    
    
    
    
}
