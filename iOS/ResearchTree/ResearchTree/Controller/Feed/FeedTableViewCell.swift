//
//  FeedTableViewCell.swift
//  ResearchTree
//
//  Created by Qiwen Guo on 12/13/18.
//  Copyright © 2018 Qiwen Guo. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.white.cgColor
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        
        
       // self.cardSetup = cardSetup
        self.cardView.alpha = 1;
        self.cardView.layer.masksToBounds = false;
        self.cardView.layer.cornerRadius = 1; // if you like rounded corners
        self.cardView.layer.shadowOffset = CGSize(width: -0.2, height: 0.2) //%%% this shadow will hang slightly down and to the right
        self.cardView.layer.shadowRadius = 3; //%%% I prefer thinner, subtler shadows, but you can play with this
        self.cardView.layer.shadowOpacity = 0.2;
        
        
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }
    


   func cardSetup()
    {
    
        cardView.alpha = 1;
        cardView.layer.masksToBounds = false;
        cardView.layer.cornerRadius = 1; // if you like rounded corners
        cardView.layer.shadowOffset = CGSize(width: -0.2, height: 0.2) //%%% this shadow will hang slightly down and to the right
        cardView.layer.shadowRadius = 1; //%%% I prefer thinner, subtler shadows, but you can play with this
        cardView.layer.shadowOpacity = 0.2; //%%% same thing with this, subtle is better for me
      //  self.backgroundColor = UIColor
    
    //%%% This is a little hard to explain, but basically, it lowers the performance required to build shadows.  If you don't use this, it will lag
  //  UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.cardView.bounds];
    //    self.cardView.layer.shadowPath = CGPath as! CGPath;
    
   // self.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1]; //%%% I prefer choosing colors programmatically than on the storyboard
    }
}
