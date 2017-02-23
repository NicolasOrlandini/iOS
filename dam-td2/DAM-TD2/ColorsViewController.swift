//
//  ColorsViewController.swift
//  DAM-TD2
//
//  Created by Nicolas Orlandini on 09/01/2017.
//  Copyright © 2017 Nicolas Orlandini. All rights reserved.
//

import UIKit

class ColorsViewController: UITableViewController{
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var tableItems = ["Swift","Python","PHP","Java","JavaScript","C#"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this method will populate the table view
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableRow = tableView.dequeueReusableCell(withIdentifier: "LabelCell") as UITableViewCell!
        
        //adding the item to table row
        tableRow?.textLabel?.text = tableItems[indexPath.row]
        
        return tableRow!
    }
    
    
    //this method will return the total rows count in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
}
