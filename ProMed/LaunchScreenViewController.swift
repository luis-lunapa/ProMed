//
//  LaunchScreenViewController.swift
//  ProMed
//
//  Created by Luis Luna on 5/12/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let user = LoginManager().localLogin() {
            
            APIManager.shared.persistencia.currentUser = user
            self.goToApp()
            
            
        } else {
            self.goToLogin()
        }
    }
    
    func goToLogin() {
        
        
        
        let viewController = storyboard!.instantiateViewController(withIdentifier: "login")
        self.present(viewController, animated: true)
  
    }
    
    func goToApp() {
        
        let storyboard = UIStoryboard.init(name: "Professionals", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "proBase")
        self.present(viewController, animated: true)
        
        
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
