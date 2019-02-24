//
//  ProfessionalAgendaViewController.swift
//  ProMed
//
//  Created by Luis Luna on 2/23/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit

class CitaTableViewCell: UITableViewCell {
    
    let backGroundColors = [
        UIColor(red:0.36, green:0.64, blue:0.68, alpha:1.0),
        UIColor(red:0.36, green:0.62, blue:0.29, alpha:1.0),
        UIColor(red:0.28, green:0.49, blue:0.73, alpha:1.0),
        UIColor(red:0.65, green:0.49, blue:0.73, alpha:1.0),
        UIColor(red:0.65, green:0.39, blue:0.73, alpha:1.0),
        UIColor(red:0.65, green:0.39, blue:0.51, alpha:1.0),
        UIColor(red:0.65, green:0.02, blue:0.25, alpha:1.0),
        UIColor(red:0.65, green:0.59, blue:0.04, alpha:1.0),
        UIColor(red:0.78, green:0.45, blue:0.04, alpha:1.0)
    ]
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backView.backgroundColor = self.backGroundColors.randomElement()!
        self.backView.layer.cornerRadius = 8
    }
    
}

class ProfessionalAgendaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Class members
    
    
    
    var citas = ["Monica Perez", "Tommy Luna", "Ricardo Luna", "Junior Luna", "Melanie Luna", "Daisy Luna", "Judy Luna", "Muñeca Luna"]
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.styleBars()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: IBActions
    
    @IBAction func addAppointmentPressed(_ sender: Any) {
        
    }
    
    
    // MARK: TableView DataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citas.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as! CitaTableViewCell
        
       
        return cell
    }
    
    
    // MARK: TableView Delegate
    
    
    
    
    // MARK: Common Setup
    
    /**
     This function sets the navigation bar and the tab bar to
     translucent
     
     - Author: Luis Gerardo Luna
     - Copyright: © Luis Luna
 
     */
    
    func styleBars() {
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
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
