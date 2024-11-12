//
//  EmployementTypeViewController.swift
//  Group-02 Project
//
//  Created by Chandan  on 11/25/23.
//

import UIKit

class EmployementTypeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var index = ""
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allEmployments.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Employment Oppurtunities"
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = emp.dequeueReusableCell(withIdentifier: "empCell", for: indexPath)
        
        cell.imageView?.image = UIImage(systemName: "person.3.fill")
        
        cell.textLabel!.text = allEmployments[indexPath.row].type
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "jobsSegue", sender: self)
    }
    

    @IBOutlet weak var emp: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        emp.dataSource = self
        emp.delegate = self
        
    }
    

    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Return the height of the header in your table view
        return 50.0 // Change to your desired height
    }
    
    
    
    @IBAction func profilePage(_ sender: Any) {
        
        performSegue(withIdentifier: "profileSegue", sender: self)
        
    }
    

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let transition = segue.identifier
        
        if (transition == "jobsSegue"){
            
           
                let destination = segue.destination as! JobsPageViewController
                
                
                destination.jobs = allEmployments[0].jobs
           
            
        }
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
