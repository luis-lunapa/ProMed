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
    
    private let refreshController = UIRefreshControl()
    
    var patientsList = [Patient]()
    var patientsListSearching = [Patient]()
    var isSearching = false
    
    // MARK: Attributes for creating appointment
    
    var selectedPatient: Patient?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKB = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(hideKB)
        self.patientsTableView.delegate = self
        self.patientsTableView.dataSource = self
        
        self.descriptionTextView.layer.borderWidth = 2
        self.descriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        self.scheduleButton.layer.cornerRadius = 8
        
        refreshController.addTarget(self, action: #selector(self.getAllPatients), for: .valueChanged)
        self.patientsTableView.refreshControl = self.refreshController
        
        
       

        // Do any additional setup after loading the view.
    }
    
    @objc func getAllPatients () {
        
        APIManager.shared.networking.getAllPatients().done {
            patients in
            
            print("PAtient")
            self.patientsList = patients
            self.isSearching = false
            self.patientsTableView.refreshControl?.endRefreshing()
            self.patientsTableView.reloadData()
            }.catch {
                error in
                let error = error as NSError
                self.patientsTableView.refreshControl?.endRefreshing()
                
                Utilidades.showAlert(title: "Oops", text: error.userInfo["msg"] as? String, sender: self)
                
                
                
                
        }
        
        
    }
    
    // MARK: IBActions
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func schedulePressed(_ sender: Any) {
        
        guard let patient = self.selectedPatient else {
            
            Utilidades.showAlert(title: "Error", text: "Select a patient to create an appointment", sender: self)
            return
        }
        let appointmentDate = self.dateTimePicker.date
        
        APIManager.shared.networking.createAppointment(patient: patient, date: appointmentDate, description: self.descriptionTextView.text).done {
            ready in
            
            Utilidades.showAlert(title: "Great", text: "The appointmment was created", sender: self)
            
            self.navigationController?.popViewController(animated: true)
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
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }

}

extension ProNewAppointmentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var patients = self.patientsList
        if self.isSearching {
            patients = self.patientsListSearching
        }
        let cell = self.patientsTableView.dequeueReusableCell(withIdentifier: "patientSchedule", for: indexPath)
        cell.textLabel?.text = patients[indexPath.row].nombre
        cell.detailTextLabel?.text = patients[indexPath.row].nss

        return cell
    }
    
    
}

extension ProNewAppointmentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if self.isSearching {
            self.selectedPatient = self.patientsListSearching[indexPath.row]
        } else {
            self.selectedPatient = self.patientsList[indexPath.row]
        }
    }
    
}
