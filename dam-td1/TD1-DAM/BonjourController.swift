//
//  BonjourController.swift
//  TD1-DAM
//
//  Created by Nicolas Orlandini on 03/01/2017.
//  Copyright © 2017 Nicolas Orlandini. All rights reserved.
//

import UIKit

class BonjourController: UIViewController {
    
    @IBOutlet weak var lblBonjour: UILabel!
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.center = CGPoint(x: 160, y: 400)
        label.textAlignment = .center
        label.text = "Bonjour programmatically"
        self.view.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        button.center = CGPoint(x: 170, y: 470)
        button.setTitleColor(UIColor.blue, for: UIControlState.normal)
        button.setTitle("Au revoir", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonAction(sender: UIButton!) {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        dateFormatter.timeZone = NSTimeZone.local
        let defaultTimeZoneStr = dateFormatter.string(from: date as Date);
        label.text = String(describing: defaultTimeZoneStr);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func testButton(_ sender: AnyObject) {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        lblBonjour.text = "\(hour):\(minutes):\(seconds)"
    }
}
