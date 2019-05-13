//
//  ProMyPatientsViewController.swift
//  ProMed
//
//  Created by Luis Luna on 2/24/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit

class ProMyPatientsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var patients = [Patient]()
    var isSearching = false
    var searchPatients = [Patient]()
    
    private let refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshController.addTarget(self, action: #selector(self.getAllPatients), for: .valueChanged)
        self.tableView.refreshControl = self.refreshController
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.getAllPatients()

        // Do any additional setup after loading the view.
    }
    
    @objc func getAllPatients () {
        
        APIManager.shared.networking.getAllPatients().done {
            patients in
            
            print("PAtient")
            self.patients = patients
            self.isSearching = false
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
            }.catch {
                error in
                let error = error as NSError
                self.tableView.refreshControl?.endRefreshing()
                
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

extension ProMyPatientsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearching {
            return self.searchPatients.count
        }
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var patients: [Patient] = self.patients
        if self.isSearching {
            patients = self.searchPatients
        }
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "patientCell", for: indexPath) as! PatientTableViewCell
        
        cell.patientName.text = patients[indexPath.row].nombre
        cell.patientAge.text = APIManager.shared.dateFormatDiaMesAnioSQL().string(from: patients[indexPath.row].nacimiento)
        cell.patientNSS.text = patients[indexPath.row].nss
        cell.patientGender.text = patients[indexPath.row].genero
        cell.patientImg.image = UIImage(named: "user")
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 119
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        var selectedUser: Patient = self.patients[indexPath.row]
        if self.isSearching {
            selectedUser = self.searchPatients[indexPath.row]
        }
        
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "patientDetails") as! ProPatientDetailsViewController
        viewController.patient = selectedUser
        self.show(viewController, sender: self)
        
        
        
        
        
    }
    
    
    
    
    
}
