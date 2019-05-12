//
//  LoginViewController.swift
//  ProMed
//
//  Created by Luis Luna on 2/15/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit
import PromiseKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        self.userNameTextField.customPlaceHolder(color: .white)
        self.passwordTextField.customPlaceHolder(color: .white)
        self.loginButton.layer.cornerRadius = 5
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        self.userNameTextField.setBottomLine(borderColor: .lightGray)
        self.passwordTextField.setBottomLine(borderColor: .lightGray)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        if self.userNameTextField.text! == "" {
            Utilidades.showAlert(title: "Error", text: "Provide your email", sender: self)
            return
        }
        
        if self.passwordTextField.text! == "" {
            Utilidades.showAlert(title: "Error", text: "Provide your password", sender: self)
            return
        }
        
        let email    = self.userNameTextField.text!
        let password = self.passwordTextField.text!
        
        APIManager.shared.networking.login(email: email, password: password).done {
            user in
            
            APIManager.shared.persistencia.currentUser = user
            /// CoreData code
            
            
            let storyboard = UIStoryboard.init(name: "Professionals", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "proBase")
            self.present(viewController, animated: true)
           
            
            
            
            
        }.catch {
            error in
            let error = error as NSError
            
            Utilidades.showAlert(title: "Oops", text: error.userInfo["msg"] as? String, sender: self)
                
                
                
                
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
