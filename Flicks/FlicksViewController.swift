//
//  FlicksViewController.swift
//  Flicks
//
//  Created by Mohammed, Mahboob Shah on 3/31/17.
//  Copyright © 2017 Mohammed, Mahboob Shah. All rights reserved.
//

import UIKit

class FlicksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var results: [NSDictionary] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //var indexPath = IndexPath.self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120;
        let url = URL(string:"http://api.themoviedb.org/3/movie/now_playing?api_key=54ae998e120ee63468a253d30a1c4261")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        //print("responseDictionary: \(responseDictionary)")
                        
                        // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                        // This is how we get the 'response' field
//                        let responseFieldDictionary = responseDictionary["results"] as! NSDictionary
//                        print("responseFieldDictionary: \(responseFieldDictionary)")
                        // This is where you will store the returned array of posts in your posts property
                        self.results = responseDictionary["results"] as! [NSDictionary]
                        //print(self.results)
                        //print(self.results.count)
                        self.tableView.reloadData()
                    }
                }
        })
        task.resume()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(results.count)
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var flick: NSDictionary
        flick = results[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.movieLabel.text = flick["title"] as? String
        cell.movieDesc.text = flick["overview"] as? String
        // Configure YourCustomCell using the outlets that you've defined.
        
        return cell
    }
}
