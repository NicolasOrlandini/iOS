//
//  ViewController.swift
//  DAM-TD4
//
//  Created by LEON Valentin on 30/01/2017.
//  Modified by ORLANDINI Nicolas.
//  Copyright © 2017 LeonOrlandini. All rights reserved.
//

import UIKit
import SWXMLHash

class ViewController: UIViewController {
    var categories: [Category] = []
    var boxView = UIView()
    var activityView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = .gray
        
        /// Création d'un UIActivityIndicatorView
        activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        parametrer(activityView: activityView)
        
        /// Charger le XML
        chargerXml()
        /// Arrêter l'animation
        stopAnimating()
        
        /// Aller sur la page TableView
        transition()
    }
    
    func transition() {
        
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "categories") as! TableViewController
        viewController.categories = self.categories
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated:true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Personnalisation de l'activityIndicator
    func parametrer(activityView: UIActivityIndicatorView) {
        
        /// Ajout d'une box qui contiendra l'activity indicator et le texte
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = UIColor.white
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        /// Ajour d'un texte
        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.textColor = UIColor.gray
        textLabel.text = "CM IS MAGIC"
        
        /// Ajout des éléments dans la box
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        /// Ajout de la box à la view
        view.addSubview(boxView)
    }
    
    func stopAnimating()
    {
        self.activityView.stopAnimating()
        //self.boxView.removeFromSuperview()
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
    
    /// Charger le fichier XML
    func chargerXml(){
        
        /// --- BONUS 1
        /// charger la langue actuelle du terminal
        let langage = getLangage()
        
        var i = 0
        //url de l'xml
        let urlString = "http://fairmont.lanoosphere.com/mobile/getdata?lang=" + langage
        
        if let url = NSURL(string: urlString){
            if let data = try? Data(contentsOf: url as URL, options: [])
            {
                let xml = SWXMLHash.config{
                    config in
                    config.shouldProcessLazily = true
                    }.parse(data)
                for item in xml["data"]["categories"]["category"]{
                    let category = Category()
                    category.id = Int(item.element!.attribute(by: "id")!.text)!
                    category.name = item.element!.attribute(by: "name")!.text
                    category.sort = item.element!.attribute(by: "sort")!.text
                    
                    //on insère dans le table de catégories
                    self.categories.append(category)
                    
                    for subitem in item["element"]{
                        let categoryId = Int(subitem.element!.attribute(by: "category_id")!.text)!
                        
                        if(categoryId == category.id){
                            let element = Element()
                            element.name = (subitem.element?.attribute(by: "name")!.text)!
                            element.desc = (subitem.element?.attribute(by: "descr")!.text)!
                            element.urlImage = (subitem.element?.attribute(by: "image")!.text)!
                            element.urlImageLarge = (subitem.element?.attribute(by: "image_large")!.text)!
                            element.email = (subitem.element?.attribute(by: "email")!.text)!
                            element.phone = (subitem.element?.attribute(by: "phone")!.text)!
                            element.subname = (subitem.element?.attribute(by: "subname")!.text)!
                            
                            self.categories[i].elements.append(element)
                        }
                    }
                    i += 1
                }
            }
            else{
                print("erreur")
            }
        }
        else{
            print("Ce n'est pas une url valide")
        }
    }
}

