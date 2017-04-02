//
//  MovieCell.swift
//  Flicks
//
//  Created by Mohammed, Mahboob Shah on 4/1/17.
//  Copyright © 2017 Mohammed, Mahboob Shah. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieLabel: UILabel!

    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieDesc: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
