//
//  JobTableViewCell.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 2/6/19.
//  Copyright © 2019 Qiwen Guo. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var cardView2: UIView!
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
        
        userImageView.layer.borderWidth = 1
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
