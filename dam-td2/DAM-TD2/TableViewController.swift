//
//  TableViewController.swift
//  DAM-TD2
//
//  Created by LEON Valentin on 12/01/2017.
//  Copyright © 2017 Nicolas Orlandini. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableview: UITableView!
    
    //déclaration des tableaux
    var colors:[String] = []
    var colorsBackground: [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colors = ["Red", "Blue", "Green", "Yellow", "Grey", "Purple", "Orange"]
        colorsBackground = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.gray, UIColor.purple, UIColor.orange]
        tableview.dataSource = self
        tableview.delegate = self
    }

    //flush de la mémoire
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //on compte le nombre de couleurs dans le tableau, et cela devient le nombre de cellules
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    //affectation du label et du background aux cellules
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text =  colors[indexPath.row]
        cell.backgroundColor = colorsBackground[indexPath.row]
        
        return cell
    }
    
    //fonction de table view permettant de changer la couleur du background de la tabbar
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabBarController?.tabBar.barTintColor = colorsBackground[indexPath.row]
    }
}
