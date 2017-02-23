//
//  MyWebViewController.swift
//  DAM-TD3
//
//
//  Créé par : LEON Valentin
//  Créé le : 17/01/2017
//  Dernière modification : 20/01/2017
//  Modifié par : ORLANDINI Nicolas
//  Copyright © 2017 LEON Valentin. All rights reserved.
//

import UIKit
import SafariServices

class MyWebViewController: UIViewController {

    @IBOutlet weak var webViewOutlet: UIWebView!
    
    public var website: String = ""
    public var titre: String = ""
    var toolBar:UIToolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webViewOutlet.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        // set title to navigation bar
        self.navigationItem.title = titre
        
        /// ----------------------------- BONUS 2 ------------------------------ ///
        /// ----------------- Personnalisation de la NavigationBar ----------------- ///
        let openSafariButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(MyWebViewController.openWithSafari))
  
        /// Ajout du bouton permettant d'ouvrir le lien avec Safari
        self.navigationItem.rightBarButtonItem = openSafariButton
        
        /// ----------------------------- BONUS 3 ------------------------------ ///
        /// ----------------- Personnalisation de la UIToolbar ----------------- ///
        
        /// Espace flexible pour créer une séparation entre les boutons
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        /// Ajout du bouton pour rafraichir la page
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webViewOutlet, action: #selector(webViewOutlet.reload))
        /// Ajout du bouton retour
        let back = UIBarButtonItem(barButtonSystemItem: .undo, target: webViewOutlet, action: #selector(webViewOutlet.goBack))
        /// Ajout du bouton suivant
        let suivant = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webViewOutlet, action: #selector(webViewOutlet.goForward))

        /// Ajout des botons à la navigationBar
        toolbarItems = [back, suivant, spacer, refresh]
        
        /// Affichage de la navigationBar
        navigationController?.isToolbarHidden = false
        
        
        // load url in the webview
        UIWebView.loadRequest(webViewOutlet)(NSURLRequest(url: NSURL(string: website)! as URL) as URLRequest)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /// Ouverture du lien avec Safari (au clic sur le bouton dans la navigationBar)
    func openWithSafari(){
        // Non déprécié mais ouvre une version allégée de Safari et non Safari
        /*let svc = SFSafariViewController(url: NSURL(string: website)! as URL)
        present(svc, animated: true, completion: nil)*/
        
        UIApplication.shared.openURL(URL(string: website)!)
    }
}
