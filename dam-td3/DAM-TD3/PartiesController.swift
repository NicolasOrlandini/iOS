//
//  PartiesController.swift
//  DAM-TD3
//
//  Created by LEON Valentin on 23/01/2017.
//  Copyright © 2017 LEON Valentin. All rights reserved.
//

import UIKit
import SWXMLHash

//classe pour les events
class Event{
    var id : String = ""
    var date : String = ""
    var name : String = ""
    //var desc : String = ""
    var flyer : String = ""
    
}

class PartiesController: UITableViewController {
    
    //enum pour les différents devices
    enum UIUserInterfaceIdiom: Int {
        case Unspecified
        case Phone
        case Pad
    }

    /* Variables et Outlets */
    var events: [Event] = []
    @IBOutlet var tableViewOutlet: UITableView!
    var isSorted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //taille d'une cellule
        tableViewOutlet.rowHeight = 180.0
        
        //url de l'xml
        let urlString = "http://sealounge.lanoosphere.com/seadata_en.xml"
       
        //on parse le xml et on lit les valeurs
        if let url = NSURL(string: urlString){
            if let data = try? Data(contentsOf: url as URL, options: [])
            {
                let xml = SWXMLHash.config{
                    config in
                    config.shouldProcessLazily = true
                }.parse(data)
                for item in xml["Data"]["Event"]{
                    let event = Event()
                    event.id = item.element!.attribute(by: "id")!.text
                    event.date = item.element!.attribute(by: "date")!.text
                    event.name = item.element!.attribute(by: "name")!.text
                    //event.desc = item.element!.attribute(by: "desc")!.text
                    event.flyer = item.element!.attribute(by: "flyer")!.text
                    
                    //on insère dans le table d'event
                    self.events.append(event)
                }
                self.tableView.reloadData()
            }
            else{
                print("erreur") // à voir pour mettre un log ou pas...
            }
        }
        else{
            print("Ce n'est pas une url valide")
        }
        
        let sortButton = UIBarButtonItem(
            title: "Trier les events",
            style: .plain,
            target: self,
            action: #selector(sortEvents(sender:))
        )
        self.navigationItem.rightBarButtonItem = sortButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellPart", for: indexPath) as! CustomCellViewTableViewCell
        let currentEvent = self.events[indexPath.row] //l'event courant
        let currentUrlImage = currentEvent.flyer
        
        //fonction asynchrone pour charger les images
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = NSURL(string: currentUrlImage){
            //animation en fadeIn à l'arrivée des images
            UIView.transition(with: cell.imageFlyerOutlet,
                              duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                let data = NSData(contentsOf: url as URL)
                                if data != nil{
                                    cell.imageFlyerOutlet.image = UIImage(data: data as! Data)
                                }
            },
                              completion: nil)
            }
        }
        
        //switch pour déterminer la taille sur un écran
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            cell.labelNameOutlet.frame.size.width = 233
            cell.labelDateOutlet.frame.size.width = 156
            cell.labelHeureOutlet.frame.origin.x = cell.labelDateOutlet.frame.maxX
            cell.labelHeureOutlet.frame.size.width = 77
            break
        case .pad:
            cell.labelNameOutlet.frame.size.width = 900
            cell.labelDateOutlet.frame.size.width = 810
            cell.labelHeureOutlet.frame.origin.x = cell.labelDateOutlet.frame.maxX
            cell.labelHeureOutlet.frame.size.width = 77
            break
        default:
            cell.labelNameOutlet.frame.size.width = 233
            cell.labelDateOutlet.frame.size.width = 156
            cell.labelHeureOutlet.frame.origin.x = cell.labelDateOutlet.frame.maxX
            cell.labelHeureOutlet.frame.size.width = 77
            break
        }
    
        //affichage du name
        cell.labelNameOutlet.text = currentEvent.name
        cell.labelNameOutlet.textAlignment = .center
        cell.labelNameOutlet.contentMode = .center
        cell.labelNameOutlet.baselineAdjustment = .alignCenters
        cell.labelNameOutlet.textColor = UIColor.white

        //convertir la date en string to date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateStringToDate = formatter.date(from: events[indexPath.row].date)!
        
        //on formate la stringDate et on le place dans le label
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        cell.labelDateOutlet.text = "Le \(dateFormatter.string(from: dateStringToDate))"
        cell.labelDateOutlet.textAlignment = .center
        cell.labelDateOutlet.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.labelDateOutlet.font = UIFont(name: cell.labelDateOutlet.font.fontName, size: 18)

        //on récupère seulement l'heure de la date
        let dateCustomFormatter = DateFormatter()
        dateCustomFormatter.dateFormat = "HH" //on formate l'heure en HH
        cell.labelHeureOutlet.text = "\(dateCustomFormatter.string(from: dateStringToDate))H"
        cell.labelHeureOutlet.textAlignment = .center
        cell.labelHeureOutlet.textColor = UIColor.white

        return cell
    }
    
    //fonction pour trier les events
    func sortEvents(sender: UIBarButtonItem) {
        
        if !isSorted{
            events = events.sorted(by: {$0.date < $1.date})
            isSorted = true
            print("dans le if : \(isSorted)")
        }
        else{
            isSorted = false
            events = events.sorted(by: {$1.date < $0.date})
            print("dans le else : \(isSorted)")
        }
        self.tableView.reloadData()
    }
}
