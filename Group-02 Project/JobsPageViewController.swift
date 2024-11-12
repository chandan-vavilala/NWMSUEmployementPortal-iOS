//
//  JobsPageViewController.swift
//  Group-02 Project
//
//  Created by Chandan  on 11/25/23.
//

import UIKit
import FirebaseAuth

class JobsPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var jobs:[Job]?
    
    var titles:String?
    
    var username:String?
    
    var email:String?
    
    
    
    @IBOutlet weak var userbtn: UIBarButtonItem!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs!.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = jobsOL.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath)
        
        cell.textLabel!.text = jobs?[indexPath.row].title
        cell.detailTextLabel!.text = jobs?[indexPath.row].description
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        performSegue(withIdentifier: "descSegue", sender: index)
    }
    
    
    
    

    @IBOutlet weak var jobsOL: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = titles

        // Do any additional setup after loading the view.
        jobsOL.dataSource = self
        jobsOL.delegate = self
        
        
    }
    
    
    @IBAction func profilePage(_ sender: Any) {
        
        performSegue(withIdentifier: "profileSegue", sender: self)
        
    }
    

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Job Openings"
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
        
    }
    
    
    
    @IBAction func homeBtn(_ sender: Any) {
        home()
    }
    

    
    
    func home(){
        let vcObj = self.storyboard?.instantiateViewController(withIdentifier: "home")
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.navigationController?.setViewControllers([vcObj!], animated: true)
        
    }
    
    
    

    @IBAction func profile(_ sender: UIBarItem) {
        showMenu()
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let transition = segue.identifier
        
        if(transition == "descSegue"){
            
            let destination = segue.destination as! JobDescriptionViewController
            
            let index = sender as? Int
            
            
            destination.job = jobs![index!]
            destination.username = username
            destination.email = email
            
        }
        
        
        if(transition == "profileSegue"){
            let destination = segue.destination as! ProfileViewController
            
            destination.username = username
            destination.email = email
            
        }
        
    }
    


}
