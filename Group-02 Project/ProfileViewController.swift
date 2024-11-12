//
//  ProfileViewController.swift
//  Group-02 Project
//
//  Created by Chandan  on 11/28/23.
//




import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var imageOL: UIImageView!
    @IBOutlet weak var DOBOL: UILabel!
    
    
    @IBOutlet weak var LogoutOL: UIBarButtonItem!
    
    
    
    
    
    @IBOutlet weak var statusOL: UILabel!
    
    
    
    var ref: DatabaseReference!
    var username: String?
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if a user is currently logged in
        if let currentUser = Auth.auth().currentUser {
            // Assuming you store the email in the 'email' attribute
            let userEmail = currentUser.email ?? "N/A"
            
            // Display the email in the emailLabel
            emailLabel.text = userEmail
            NameLabel.text = username
            
            // Use the email to retrieve the username from the database
            let emailForDatabase = userEmail.replacingOccurrences(of: ".", with: ",")
            let userRef = Database.database().reference().child("Users").child(emailForDatabase)
            
            userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.exists() {
                    if let userData = snapshot.value as? [String: Any],
                       let firstname = userData["firstName"] as? String,
                       let lastname = userData["lastName"] as? String,
                       let dob = userData["dob"] as? String {
                        
                        // Display the username in the NameLabel
                        let username = "\(firstname) \(lastname)"
                        DispatchQueue.main.async {
                            self.NameLabel.text = username
                            self.DOBOL.text = dob
                        }
                    } else {
                        print("Error: Unable to parse user data")
                    }
                } else {
                    print("Error: User does not exist in the database")
                    print(emailForDatabase)
                }
            }) { (error) in
                print("Error fetching user data: \(error.localizedDescription)")
            }
        } else {
            print("No user is currently logged in.")
        }
    }
    
    @IBAction func logoutOL(_ sender: Any) {
        // Perform logout and segue to the login page
        try? Auth.auth().signOut()
        
        let vcObj = self.storyboard?.instantiateViewController(withIdentifier: "login")
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.setViewControllers([vcObj!], animated: true)
      
    }
    
    
    @IBAction func updatePassword(_ sender: Any) {
        // Display an alert to get the new password
        let alert = UIAlertController(title: "Update Password", message: "Enter your new password", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "New Password"
            textField.isSecureTextEntry = true
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { [weak self] _ in
            if let newPassword = alert.textFields?.first?.text {
                print("Updating password to: \(newPassword)")
                self?.updatePassword(newPassword)
            }
        }))

        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func deactivateOL(_ sender: Any) {
        // Display an alert to confirm the deletion
        let alert = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteAccount()
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    
 
    
    func deleteAccount() {
        // Delete the user's account from Firebase
        Auth.auth().currentUser?.delete { [weak self] error in
            if let error = error {
                print("Error deleting account: \(error.localizedDescription)")
            } else {
                // Account deleted successfully, redirect to login page
                let vcObj = self?.storyboard?.instantiateViewController(withIdentifier: "login")
                self?.navigationController?.navigationBar.prefersLargeTitles = false
                self?.navigationController?.setViewControllers([vcObj!], animated: true)
            }
        }
    }

    func updatePassword(_ newPassword: String) {
        // Update the user's password in Firebase
        Auth.auth().currentUser?.updatePassword(to: newPassword) { [weak self] error in
            if let error = error {
                print("Error updating password: \(error.localizedDescription)")
                self?.statusOL.text = "Error updating password: \(error.localizedDescription)"
                
                
            } else {
                print("Password updated successfully")
                self?.statusOL.text = "Password Updated Successfully!!!"
                // Password updated successfully, you can inform the user
            }
        }
    }

}
