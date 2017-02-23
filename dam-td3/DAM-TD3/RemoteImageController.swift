//
//  RemoteImageController.swift
//  DAM-TD3
//
//  Créé par : LEON Valentin
//  Créé le : 16/01/2017
//  Dernière modification : 20/01/2017
//  Modifié par : ORLANDINI Nicolas
//  Copyright © 2017 LEON Valentin. All rights reserved.
//

import UIKit

class RemoteImageController: UIViewController {

    @IBOutlet weak var btnAddImageObject: UIButton!
    @IBOutlet weak var btnOpenImage: UIButton!
    var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Ajoute un objet UIImageView de couleur noire (pour la reconnaitre) sur le .view de la TabBarController
    @IBAction func addImageButton(_ sender: AnyObject) {
        image = UIImageView(frame: CGRect(x: CGFloat(0), y: CGFloat(25), width: self.view.frame.size.width, height: CGFloat(768)))
        image.backgroundColor = UIColor.black
        /// Permet à l'image de prendre toute la largeur de l'écran
        image.contentMode = .scaleAspectFit
        self.view.addSubview(image)
        
    }
    
    /// Définit une image depuis le bundle de l’application à l’objet UIImageView
    @IBAction func openImage(_ sender: AnyObject) {
        if (image != nil){
            image.backgroundColor = UIColor.clear
            image.image = UIImage(named: "deloreanoblique")
        }
    }
    
    /// Charge une image à partir d’une URL externe et qui définit celle-ci dans l’object UIImageView
    @IBAction func openImageUrl(_ sender: AnyObject) {
        if (image != nil){
            /// Si l'URL existe et que son contenu n'est pas vide, on l'affecte à l'image
            if let url = NSURL(string: "https://i.ytimg.com/vi/cklw-Yu3moE/maxresdefault.jpg"){
                let data = NSData(contentsOf: url as URL)
                if data != nil{
                    image.backgroundColor = UIColor.clear
                    image.image = UIImage(data: data as! Data)
                }
            }
        }
    }

}

