//
//  LoginViewController.swift
//  ProMed
//
//  Created by Luis Luna on 2/15/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit

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
        
        let storyboard = UIStoryboard.init(name: "Professionals", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "proBase")
        self.present(vc, animated: true)
        
    }
    
    private func validateData() -> Bool {
        var ready = true
        
        return ready
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
