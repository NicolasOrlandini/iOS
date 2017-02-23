//
//  CustomCellViewTableViewCell.swift
//  DAM-TD3
//
//  Created by Valentin LEON on 25/01/2017.
//  Copyright © 2017 LEON Valentin. All rights reserved.
//

import UIKit

/* Classe pour accéder aux composants sur la cellule */
class CustomCellViewTableViewCell: UITableViewCell {
    
    /* Outlet pour les composants sur la cellule */
    @IBOutlet weak var labelDateOutlet: UILabel!
    @IBOutlet weak var labelHeureOutlet: UILabel!
    @IBOutlet weak var labelNameOutlet: UILabel!
    @IBOutlet weak var imageFlyerOutlet: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
