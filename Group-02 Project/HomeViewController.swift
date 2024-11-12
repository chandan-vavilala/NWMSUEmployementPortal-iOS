import UIKit
import FirebaseDatabaseInternal
import FirebaseAuth

class HomeViewController: UIViewController {

    var username: String?
    var email: String?

    
    @IBOutlet weak var usernameOL: UILabel!
    @IBOutlet weak var imageOL: UIImageView!

    @IBOutlet weak var logoOL: UIImageView!

    @IBOutlet weak var userbtn: UIBarButtonItem!

    
    @IBOutlet weak var nameBtn: UIBarButtonItem!
    
    
    
    var imageIndex = 0
    var images: [UIImage] = [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image3")!]
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
        let username = username
       
        
        //nameBtn.title = username
        let user = Auth.auth().currentUser?.email
        
        let emailForDatabase = user!.replacingOccurrences(of: ".", with: ",")
        let userRef = Database.database().reference().child("Users").child(emailForDatabase)

        
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let userData = snapshot.value as? [String: Any],
                   let firstname = userData["firstName"] as? String,
                   let lastname = userData["lastName"] as? String
                    
                {
                    // Display the username in the NameLabel
                    let username = "\(firstname) \(lastname)"
                    DispatchQueue.main.async {
                        self.nameBtn.title = username
                 
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
    

        // Setup initial image
        updateImage()

        
        // Start slideshow timer
        startSlideshowTimer()
        
    }
 
    func updateImage() {
        let newImage = images[imageIndex]
        UIView.transition(with: imageOL,
                          duration: 0.5,
                          options: .transitionFlipFromBottom,
                          animations: {
                              self.imageOL.image = newImage
                          },
                          completion: nil)
    }

    
    func startSlideshowTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            // Increment image index
            self.imageIndex = (self.imageIndex + 1) % self.images.count

            // Update the image
            self.updateImage()
        }
    }
    
    
    

    @IBAction func gradJobsActn(_ sender: Any) {
        performSegue(withIdentifier: "gradSegue", sender: self)
    }

    @IBAction func studentsJobsActn(_ sender: Any) {
        performSegue(withIdentifier: "studentSegue", sender: self)
    }

    @IBAction func staffJobsActn(_ sender: Any) {
        performSegue(withIdentifier: "staffSegue", sender: self)
    }

    @IBAction func offcampusJobsActn(_ sender: Any) {
        performSegue(withIdentifier: "offcampusSegue", sender: self)
    }

    
    @IBAction func Profile(_ sender: Any) {
        showMenu()
    }
    
    
    @IBAction func homeBtn(_ sender: Any) {
        home()
    }
    

    
    
    func home(){
        let vcObj = self.storyboard?.instantiateViewController(withIdentifier: "home")
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.navigationController?.setViewControllers([vcObj!], animated: true)
        
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

        if transition == "gradSegue" {
            let destination = segue.destination as! JobsPageViewController
            destination.titles = "Graduation Jobs"
            destination.jobs = allEmployments[1].jobs
            destination.username = username
            destination.email = email
        } else if transition == "studentSegue" {
            let destination = segue.destination as! JobsPageViewController
            destination.titles = "Student Jobs"
            destination.username = username
            destination.jobs = allEmployments[3].jobs
            destination.email = email
        } else if transition == "staffSegue" {
            let destination = segue.destination as! JobsPageViewController
            destination.username = username
            destination.titles = "Staff Jobs"
            destination.jobs = allEmployments[0].jobs
            destination.email = email
        } else if transition == "offcampusSegue" {
            let destination = segue.destination as! JobsPageViewController
            destination.username = username
            destination.titles = "OffCampus/Dining Jobs"
            destination.jobs = allEmployments[2].jobs
            destination.email = email
        } else if transition == "profileSegue" {
            let destination = segue.destination as! ProfileViewController
            destination.username = username
            destination.email = email
        }
    }
}
