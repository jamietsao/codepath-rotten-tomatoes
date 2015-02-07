//
//  MovieTableViewCell.swift
//  RottenTomatoes
//
//  Created by Jamie Tsao on 2/4/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var abridgedCast: UILabel!
    @IBOutlet weak var criticsRatingImage: UIImageView!
    @IBOutlet weak var criticsRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
