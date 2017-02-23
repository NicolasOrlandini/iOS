//
//  WebsitesTableViewController.swift
//  DAM-TD3
//
//  Créé par : ORLANDINI Nicolas
//  Créé le : 16/01/2017
//  Dernière modification : 20/01/2017
//  Modifié par : ORLANDINI Nicolas
//  Copyright © 2017 ORLANDINI Nicolas. All rights reserved.
//

import UIKit

class WebsitesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var titles:[String] = []
    var websites:[String] = []
    var favicon:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titles = ["Google", "Youtube", "Apple", "Amazon"]
        websites = ["https://www.google.fr", "https://www.youtube.com", "http://www.apple.com/fr/", "https://www.amazon.fr"]
        favicon = ["https://www.google.fr/favicon.ico", "https://www.youtube.com/favicon.ico", "http://www.apple.com/favicon.ico", "https://www.amazon.fr/favicon.ico"]
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        tableViewOutlet.rowHeight = 60.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") else {
                return UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "TableCell")
            }
            return cell
        }()
        
        //on crée les deux labels
        let textLabel = UILabel(frame: CGRect(x: CGFloat(70), y: -30, width: cell.frame.size.width, height: cell.frame.size.height))
        let textLabelDetail = UILabel(frame: CGRect(x: CGFloat(75), y: -5, width: cell.frame.size.width, height: cell.frame.size.height))
        
        //on met les propriétés et le texte
        textLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        textLabel.text = titles[indexPath.row]
        textLabelDetail.text = websites[indexPath.row]
        
        //on ajoute à la cellule
        cell.contentView.addSubview(textLabel)
        cell.contentView.addSubview(textLabelDetail)
        
        //ajout de l'image
        let imv = UIImageView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(60), height: (60)))
        if let url = NSURL(string: favicon[indexPath.row]){
            let data = NSData(contentsOf: url as URL)
            if data != nil{
                imv.image = UIImage(data: data as! Data)
                imv.backgroundColor = UIColor.darkGray
                imv.contentMode = .center
                cell.contentView.addSubview(imv)
            }
        }
        
        //------- shadow -------
        /*cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.6
        
        cell.clipsToBounds = false
        
        let shadowFrame: CGRect = (cell.layer.bounds)
        let shadowPath: CGPath = UIBezierPath(rect: shadowFrame).cgPath
        cell.layer.shadowPath = shadowPath*/
        //-----------------------
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewview") as? MyWebViewController {
            viewController.website = websites[indexPath.row]
            viewController.titre = titles[indexPath.row]
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
                
            }
        }
    }

    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.contentView.backgroundColor = UIColor.clear
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 80))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 3.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.5
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
    }
}
