//
//  SquaresViewController.swift
//  DAM-TD2
//
//  Created by Nicolas Orlandini on 09/01/2017.
//  Copyright © 2017 Nicolas Orlandini. All rights reserved.
//

import UIKit

class SquaresViewController: UIViewController {

    @IBOutlet weak var buttonAlign: UIButton!
    var red = UIView()
    var blue = UIView()
    var green = UIView()
    var etatAnim = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAlign.layer.cornerRadius = 5
        
        red = UIView(frame: CGRect(x: 10, y: 50, width: 300, height: 110))
        red.backgroundColor = UIColor.red
        self.view.addSubview(red)
        
        blue = UIView(frame: CGRect(x: 70, y: 180, width: 50, height: 90))
        blue.backgroundColor = UIColor.blue
        self.view.addSubview(blue)
        
        green = UIView(frame: CGRect(x: 60, y: 280, width: 220, height: 130))
        green.backgroundColor = UIColor.green
        self.view.addSubview(green)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionButtonAlign(_ sender: AnyObject) {
        animationAlignement()
    }
    
    func animationAlignement(){
        if etatAnim{
            UIView.animate(withDuration: 1.0, animations: {
                self.red.frame.origin.x = 15
                self.blue.frame.origin.x = 15
                self.green.frame.origin.x = 15
            })
            etatAnim = false
        }
        else{
            UIView.animate(withDuration: 1.0, animations: {
                self.red.frame.origin.x = 10
                self.blue.frame.origin.x = 70
                self.green.frame.origin.x = 60
            })
            etatAnim = true
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
