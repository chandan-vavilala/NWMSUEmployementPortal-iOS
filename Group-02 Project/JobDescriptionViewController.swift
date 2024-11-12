//
//  JobDescriptionViewController.swift
//  Group-02 Project
//
//  Created by Chandan  on 11/25/23.
//

import UIKit

class JobDescriptionViewController: UIViewController {

    
    
   
    
    var job:Job?
    var username:String?
    var email:String?
    
    @IBOutlet weak var titleOL: UILabel!
    
    
    @IBOutlet weak var requirementsOL: UILabel!
    
    @IBOutlet weak var descOL: UILabel!
    
    @IBOutlet weak var salaryOL: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = job?.title
        // Do any additional setup after loading the view.
        
        titleOL.text = "Title: \n\(String(job?.title ?? ""))"
        descOL.text = "Description: \n\(String(describing: job?.description ?? ""))"
        salaryOL.text = "Salary: \n\(job?.salary ?? 0.0)"
        
        requirementsOL.text = "Requirements: \n\(job?.requirements.joined(separator: "\n") ?? "")"
        

        
    }

    @IBAction func profilePage(_ sender: Any) {
        
        performSegue(withIdentifier: "profileSegue", sender: self)
    }
    
    
    
    
    @IBAction func applyBtn(_ sender: Any) {
        
        
        performSegue(withIdentifier: "formSegue", sender: self)
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let transition = segue.identifier
        
        if (transition == "formSegue"){
            let destination = segue.destination as! ApplicantinfoViewController
            
            destination.job = job
            
            destination.username = username
            destination.email = email
            
            
            
        }
        if transition == "profileSegue"{
            let destination = segue.destination as! ProfileViewController
            
            destination.username = username
            destination.email = email
            
            
        }
    }
    
    
    


}
