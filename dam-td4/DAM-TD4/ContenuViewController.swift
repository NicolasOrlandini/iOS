//
//  MyCustomViewController.swift
//  DAM-TD4
//
//  Created by LEON Valentin on 06/02/2017.
//  Modified by ORLANDINI Nicolas.
//  Copyright © 2017 LeonOrlandini. All rights reserved.
//

import UIKit
import SafariServices

class ContenuViewController: UIViewController {
    
    @IBOutlet weak var webviewOutlet: UIWebView!
    
    public var name: String = ""
    public var urlImage: String = ""
    public var desc: String = ""
    
    var toolBar:UIToolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Titre de la navigationBar
        self.navigationItem.title = name
        
        chargerContenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Chargement de l'image et si celle-ci n'est pas disponible on charge le text de description
    func chargerContenu() {
        if urlImage != "" {
            webviewOutlet.loadRequest(URLRequest(url: URL(string: urlImage)!))
        }else{
            let htmlCode = self.desc
            webviewOutlet.loadHTMLString(htmlCode, baseURL: nil)
        }
    }
}
