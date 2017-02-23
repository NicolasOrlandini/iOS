//
//  TableViewController.swift
//  DAM-TD4
//
//  Created by LEON Valentin on 30/01/2017.
//  Modified by ORLANDINI Nicolas.
//  Copyright © 2017 LeonOrlandini. All rights reserved.
//

import UIKit
import SWXMLHash
import SDWebImage

class Element {
    var name = ""
    var desc = ""
    var urlImage = ""
    var urlImageLarge = ""
    var email = ""
    var phone = ""
    var subname = ""
}

class TableViewController: UITableViewController {

    @IBOutlet weak var outletTitleTableView: UINavigationItem!
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //suppression du titre de l'item de navigation
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        //changer couleur du chevron en blanc
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        /// Changement de la couleur de la navigationBar et du texte
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        /// Création du bouton permettant d'afficher le formulaire
        let openFormulaireButton = UIBarButtonItem(title: "Contact", style: .plain, target: self, action: #selector(TableViewController.openFormulaire))
        
        /// Ajout du bouton permettant d'afficher le formulaire
        self.navigationItem.rightBarButtonItem = openFormulaireButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// --- BONUS 1
    /// charger la langue actuelle du terminal
    func getLangage() -> String {
        var langage = "en"
        if let countryCode = (Locale.current as NSLocale).object(forKey: .languageCode) as? String {
            langage = countryCode
        }
        return langage
    }

    
    /// Ouverture de la page contenant le formulaire
    func openFormulaire(){
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "formulaire") as? FormulaireViewController {
            
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.categories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories[section].elements.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.categories[section].name
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! CustomTableViewCell
        
        let imgView = cell.imageViewOutlet;
        
        //On change l'image par défaut
        imgView?.image = UIImage(named: "delorean")
        
        //On récupère les informations
        let name = self.categories[indexPath.section].elements[indexPath.row].name
        let image = self.categories[indexPath.section].elements[indexPath.row].urlImage
        
        cell.lblOutletNameElement?.text = name
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            if let data = try? Data(contentsOf: NSURL(string: image) as! URL) {
                DispatchQueue.main.async(execute: {
                    
                    imgView?.alpha = 0
                    
                    UIView.transition(with: imgView!, duration: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
                        imgView?.image = UIImage(data: data)
                        imgView?.alpha = 1
                    }, completion: { (ended) -> Void in
                        
                    })
                })
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.textColor = UIColor.white
            headerTitle.backgroundView?.backgroundColor = UIColor.gray
            headerTitle.textLabel?.textAlignment = .center
            headerTitle.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contenuView") as? ContenuViewController {
            //viewController
            viewController.name = self.categories[indexPath.section].elements[indexPath.row].name
            viewController.desc = self.categories[indexPath.section].elements[indexPath.row].desc
            viewController.urlImage = self.categories[indexPath.section].elements[indexPath.row].urlImageLarge
            
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
                
            }
        }
    }
}
