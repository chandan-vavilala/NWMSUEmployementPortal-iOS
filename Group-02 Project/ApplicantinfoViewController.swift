//
//  ApplicantinfoViewController.swift
//  Group-02 Project
//
//  Created by Chandan  on 11/25/23.
//



import UIKit
import FirebaseDatabase
import FirebaseDatabaseInternal
import FirebaseAuth

class ApplicantinfoViewController: UIViewController, UITextFieldDelegate {

    
    
    
    @IBOutlet weak var nameOL: UITextField!
    @IBOutlet weak var emailOL: UITextField!
    @IBOutlet weak var DOBOL: UITextField!
    @IBOutlet weak var QualificationOL: UITextField!
    @IBOutlet weak var factsOL: UITextField!
    @IBOutlet weak var jobOL: UITextField!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var userbtn: UIBarButtonItem!
    
    
    
    var name = ""
    var email:String?
    var username: String?
    var job: Job?
    var ref: DatabaseReference!
    
    var datePicker: UIDatePicker?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        if let currentUser = Auth.auth().currentUser {
            
            let userEmail = currentUser.email ?? "N/A"

            
            self.emailOL.text = userEmail
        
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
                            self.nameOL.text = username
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

        ref = Database.database().reference()

        nameOL.delegate = self
        emailOL.delegate = self
        DOBOL.delegate = self
        QualificationOL.delegate = self
        factsOL.delegate = self
        jobOL.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        jobOL.text = "\(job?.title ?? "")"
        
        
        
        jobOL.isEnabled = false
        nameOL.isEnabled = false
        emailOL.isEnabled = false
        DOBOL.isEnabled = false
        

        // Set up the Date Picker for DOBOL
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        DOBOL.inputView = datePicker

        // Add a toolbar with a Done button to dismiss the Date Picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDoneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
        DOBOL.inputAccessoryView = toolbar
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

    @objc func datePickerDoneButtonPressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        DOBOL.text = formatter.string(from: datePicker?.date ?? Date())
        DOBOL.resignFirstResponder()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    
    @IBAction func homeBtn(_ sender: Any) {
        let vcObj = self.storyboard?.instantiateViewController(withIdentifier: "home")
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.navigationController?.setViewControllers([vcObj!], animated: true)

    }
    
    
    @IBAction func profilePage(_ sender: Any) {
       // performSegue(withIdentifier: "profileSegue", sender: self)
        
        showMenu()
    }
    
    
    
    
    func logout() {
        
        
        let alert = UIAlertController(title: "Are you sure you want to logout", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        let okAction = UIAlertAction(title: "Logout", style: .destructive)  {_ in
            
            
                try? Auth.auth().signOut()
                
                
                let vcObj = self.storyboard?.instantiateViewController(withIdentifier: "login")
                
                self.navigationController?.navigationBar.prefersLargeTitles = false
                
                self.navigationController?.setViewControllers([vcObj!], animated: true)
            

        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
        
}


    
    func showMenu() {
        let alertController = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)

        let profileAction = UIAlertAction(title: "Profile Page", style: .default) { [weak self] _ in
            self?.performSegue(withIdentifier: "profileSegue", sender: self)
        }

        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { [weak self] _ in
            self?.logout()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(profileAction)
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)

        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = userbtn
        }

        present(alertController, animated: true, completion: nil)
    }
    
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "confirmationSegue") {
            let destination = segue.destination as! ApplicationSubmittedViewController
            destination.jobtitle = job?.title
            destination.name = username ?? ""
            destination.email = email ?? ""
        }
        if segue.identifier == "profileSegue" {
            let destination = segue.destination as! ProfileViewController
            destination.username = username
        }
    }

    @IBAction func submitAppplicationActn(_ sender: Any) {
        let applicationRef = ref?.child("Applications").childByAutoId()

        applicationRef!.child("UserName").setValue(nameOL.text)
        applicationRef!.child("Email").setValue(emailOL.text)
        applicationRef!.child("DOB").setValue(DOBOL.text)
        applicationRef!.child("Qualification").setValue(QualificationOL.text)
        applicationRef!.child("Facts").setValue(factsOL.text)
        applicationRef!.child("Position").setValue(job?.title)
        

        performSegue(withIdentifier: "confirmationSegue", sender: self)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameOL:
            emailOL.becomeFirstResponder()
        case emailOL:
            DOBOL.becomeFirstResponder()
        case DOBOL:
            QualificationOL.becomeFirstResponder()
        case QualificationOL:
            factsOL.becomeFirstResponder()
        case factsOL:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}



