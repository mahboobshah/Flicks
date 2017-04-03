//
//  FlickDetailViewController.swift
//  Flicks
//
//  Created by Mohammed, Mahboob Shah on 4/2/17.
//  Copyright © 2017 Mohammed, Mahboob Shah. All rights reserved.
//

import UIKit
import AFNetworking

class FlickDetailViewController: UIViewController {
    var flick: NSDictionary?

    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var flickTitle: UILabel!
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var backDropImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: detailsView.bounds.height * 2)
        scrollView.addSubview(detailsView)

        // Do any additional setup after loading the view.
        flickTitle.text = flick?["title"] as! String
        releaseDate.text = flick?["release_date"] as! String
        overviewText.text = flick?["overview"] as! String
        overviewText.sizeToFit()
        let avgRating = flick?["vote_average"] as! Int
        rating.text = String(avgRating)
        if let backDropPath = flick?["poster_path"] as? String {
            let backDropURL = "https://image.tmdb.org/t/p/w500\(backDropPath)"
            
            if let imageUrl = URL(string: backDropURL) {
                backDropImage.setImageWith(imageUrl)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
