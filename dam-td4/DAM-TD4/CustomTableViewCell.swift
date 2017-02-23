//
//  CustomTableViewCell.swift
//  DAM-TD4
//
//  Created by LEON Valentin on 06/02/2017.
//  Copyright © 2017 LeonOrlandini. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var btnChevronOutlet: UIButton!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var lblOutletNameElement: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
