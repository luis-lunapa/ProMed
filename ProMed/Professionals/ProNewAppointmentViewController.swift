//
//  ProfessionalScheduleViewController.swift
//  ProMed
//
//  Created by Luis Luna on 2/23/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit

class ProNewAppointmentViewController: UIViewController {
    
    @IBOutlet weak var patientsTableView: UITableView!
    
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var scheduleButton: UIButton!
    
    var patientsList = [Patient]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKB = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(hideKB)
        self.patientsTableView.delegate = self
        self.patientsTableView.dataSource = self
        
        self.descriptionTextView.layer.borderWidth = 2
        self.descriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        
       

        // Do any additional setup after loading the view.
    }
    
    // MARK: IBActions
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true)
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
        self.view.endEditing(true)
    }

}

extension ProNewAppointmentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//self.patientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.patientsTableView.dequeueReusableCell(withIdentifier: "patientSchedule", for: indexPath)
        cell.textLabel?.text = "Juan Perez"
        
        return cell
    }
    
    
}

extension ProNewAppointmentViewController: UITableViewDelegate {
    
}
