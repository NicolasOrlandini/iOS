//
//  FormulaireViewController.swift
//  DAM-TD4
//
//  Created by Nicolas Orlandini on 08/02/2017.
//  Modified by ORLANDINI Nicolas.
//  Copyright © 2017 LeonOrlandini. All rights reserved.
//

import UIKit
import MessageUI

class FormulaireViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate {

    /* Outlets */
    @IBOutlet weak var txtNameOutlet: UITextField!
    @IBOutlet weak var txtFirstnameOutlet: UITextField!
    @IBOutlet weak var txtMailOutlet: UITextField!
    @IBOutlet weak var txtPhoneOutlet: UITextField!
    
    @IBOutlet weak var switchOutlet: UISwitch!
    var switchValue = ""
    
    let borderColorError : UIColor = UIColor.red //couleur pour les bordures
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Contour rouge pour les textfield (préparation en cas de saisie incorrecte)
        txtNameOutlet.layer.borderColor = borderColorError.cgColor
        txtFirstnameOutlet.layer.borderColor = borderColorError.cgColor
        txtPhoneOutlet.layer.borderColor = borderColorError.cgColor
        txtMailOutlet.layer.borderColor = borderColorError.cgColor
        
        configurerAutoHideClavier()
        
        configurerBoutonDoneClavier()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Cacher le clavier lorsque l'utilisateur appuie sur le bouton "Done"
    func doneButtonAction(){
        self.view.endEditing(true)
    }
    
    //action sur le bouton d'envoi
    @IBAction func btnSendMail(_ sender: Any) {
        checkInputs()
    }
    
    @IBAction func switchValue(_ sender: UISwitch) {
        if switchOutlet.isOn{
            switchValue = "OUI"
        }
        else{
            switchValue = "NON"
        }
    }
    
    /// Configuration du bouton "Done" au dessus du clavier permettant de cacher ce dernier
    func configurerBoutonDoneClavier(){
        /// Initialisation de la toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
        // Le bouton sera placé à droite
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(FormulaireViewController.doneButtonAction))
        
        var arr = [UIBarButtonItem]()
        arr.append(flexSpace)
        arr.append(doneBtn)
        toolbar.setItems(arr, animated: false)
        toolbar.sizeToFit()
        
        // La toolbar est appliquée au clavier contextuels des textView
        self.txtNameOutlet.inputAccessoryView = toolbar
        self.txtFirstnameOutlet.inputAccessoryView = toolbar
        self.txtMailOutlet.inputAccessoryView = toolbar
        self.txtPhoneOutlet.inputAccessoryView = toolbar
    }
    
    /// Le clavier est caché lorsque l'utilisateur appuie en dehors d'un textfield
    func configurerAutoHideClavier(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    //on vérifie chaque input
    func checkInputs(){
        var isValid = true
        
        txtNameOutlet.layer.borderWidth = 0
        txtFirstnameOutlet.layer.borderWidth = 0
        txtPhoneOutlet.layer.borderWidth = 0
        txtMailOutlet.layer.borderWidth = 0

        
        if !isValidInputName(input: txtNameOutlet.text!) {
            txtNameOutlet.layer.borderWidth = 1.0
            isValid = false
        }
        
        if !isValidInputName(input: txtFirstnameOutlet.text!) {
            txtFirstnameOutlet.layer.borderWidth = 1.0
            isValid = false
        }
        
        if !isValidPhoneNumber(input: txtPhoneOutlet.text!) {
            txtPhoneOutlet.layer.borderWidth = 1.0
            isValid = false
        }
        
        if !isValidEmail(input: txtMailOutlet.text!) {
            txtMailOutlet.layer.borderWidth = 1.0
            isValid = false
        }
        
        if isValid
        {
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }
        else{
            let alert = UIAlertController(title: "Formulaire", message: "Tous les champs sont obligatoires", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "J'ai compris", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //fonction d'envoi de mail
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        let bodyMessage = "<div><p><u>Nom :</u> </p>" + self.txtNameOutlet.text! +
                          "<p><u>Prénom :</u></p>" + self.txtFirstnameOutlet.text! +
                          "<p><u>E-mail :</u></p>" + self.txtMailOutlet.text! +
                          "<p><u>Téléphone :</u></p>" + self.txtPhoneOutlet.text! +
                          "<p><u>Etre rappelé : </u></p></div>" + self.switchValue
        
        mailComposerVC.setToRecipients([self.txtMailOutlet.text!])
        mailComposerVC.setSubject("Ma demande de contact")
        mailComposerVC.setMessageBody(bodyMessage, isHTML: true)
        
        return mailComposerVC
    }
    
    //fonction envoyant un message d'alert d'erreur
    func showSendMailErrorAlert() {
        
        let alertMailError = UIAlertController(title: "Impossible d'envoyer le mail", message: "Votre appareil ne peut pas envoyer d'e-mail.  Veuillez vérifier la configuration d'envoi d'e-mail.", preferredStyle: UIAlertControllerStyle.alert)
        alertMailError.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertMailError, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    /// --- BONUS 3
    /// les inputs au bon format ainsi qu'une taille minimale
    
    //valider le nom (ou le prénom)
    func isValidInputName(input:String) -> Bool {
        let RegEx = "^[a-zA-Z\\_]{3,}$" //chiffre ou lettre, longueur 3 ou plus
        
        let nameTest = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return nameTest.evaluate(with: input) && input != ""
    }
    
    //valider le téléphone
    func isValidPhoneNumber(input:String) -> Bool {
        let RegEx = "^[0-9\\_]{10,}$" //on autorise que les chiffres, longueur 10 ou plus
        
        let phoneNumberTest = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return phoneNumberTest.evaluate(with: input) && input != ""
    }
    
    //valider l'adresse mail
    func isValidEmail(input:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: input) && input != ""
    }
}
