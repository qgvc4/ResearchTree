//
//  JobTableViewCell.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 2/6/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var jorDescription: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var standing: UILabel!
    @IBOutlet weak var paymentImageView: UIImageView!
    @IBOutlet weak var majors: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
