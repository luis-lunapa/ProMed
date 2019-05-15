//
//  ProNewPatientViewController.swift
//  ProMed
//
//  Created by Luis Luna on 5/14/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit

class ProNewPatientViewController: UIViewController {
    
    /// MARK: - IBOutlets
    
    @IBOutlet weak var patientName: UITextField!
    @IBOutlet weak var patientEmail: UITextField!
    @IBOutlet weak var patientPhone: UITextField!
    @IBOutlet weak var patientSSN: UITextField!
    
    
    @IBOutlet weak var datePicker: UIDatePicker! //
    
    @IBOutlet weak var patientGender: UITextField! ///
    
    
    @IBOutlet weak var createPatientButton: UIButton!
    
    @IBOutlet weak var descriptionText: UITextView!
    
    var fechaNacimiento: Date?
    var genero: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.hideKeyboard))
        
        self.view.addGestureRecognizer(tap)
        
        self.setupViews()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupViews() {
        self.navigationController?.navigationBar.backgroundColor = UIColor(red:0.34, green:0.27, blue:0.50, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func dateSetted(_ sender: Any) {
        
        self.fechaNacimiento = self.datePicker.date
        
    }
    
    
    
    
    
    
    @IBAction func createPatientPressed(_ sender: Any) {
        
        if !validateData() {return}
        
        
        
        
        
        
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    func validateData() -> Bool {
        var ready = true
        var msg = """
"""
        
        if self.patientName.text! == "" {
            msg = """
Patient's name \n
"""
  
        }
        
        if self.patientEmail.text! == "" {
            msg = """
            Patient's email \n
            """
            ready = false
        }
        
        if self.patientPhone.text! == "" {
            msg = """
            Patient's patientPhone \n
            """
            ready = false
            
        }
        
        if self.patientSSN.text! == "" {
            msg = """
            Patient's name \n
            """
            ready = false
            
        }
        
        if self.fechaNacimiento == nil {
            msg = """
            Patient's birthdate \n
            """
            ready = false
            
        }
        
        if self.genero == nil {
            msg = """
            Patient's gender \n
            """
            ready = false
            
        }
        
        
        if !ready {
            
            Utilidades.showAlert(title: "Incomplete information", text: msg, sender: self)
            
        }
        
        
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
    
    @objc func hideKeyboard() {
        print("HIDE !")
        self.view.endEditing(true)
    }

}

extension ProNewPatientViewController: UITextFieldDelegate {
    
    
    
    
}

