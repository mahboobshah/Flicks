//
//  FlicksViewController.swift
//  Flicks
//
//  Created by Mohammed, Mahboob Shah on 3/31/17.
//  Copyright © 2017 Mohammed, Mahboob Shah. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class FlicksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkErrorView: UIView!
    var results: [NSDictionary] = []
    var connection: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        //var indexPath = IndexPath.self
        MBProgressHUD.showAdded(to: tableView, animated: true)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
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
                if (error != nil) {
                    self.networkErrorView.isHidden = false
                    self.connection = false
                    MBProgressHUD.hide(for: self.tableView, animated: true)
                } else {
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
                            MBProgressHUD.hide(for: self.tableView, animated: true)
                            self.tableView.reloadData()
                        }
                    }
                }
        })
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(connection) {
            networkErrorView.isHidden = true
        }
        //networkErrorView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as?FlickDetailViewController
        var indexPath: IndexPath?
        indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
        
        destinationViewController?.flick = results[(indexPath?.row)!]
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
        if let posterPath = flick["poster_path"] as? String {
            // photos is NOT nil, go ahead and access element 0 and run the code in the curly braces
            let posterURL = "https://image.tmdb.org/t/p/w500\(posterPath)"
            
            let imgURL = URL(string: posterURL)!
            cell.movieImage.setImageWith(imgURL)
        }
        else {
            // photos is nil. Good thing we didn't try to unwrap it!
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        MBProgressHUD.showAdded(to: tableView, animated: true)
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
                if (error != nil) {
                    self.networkErrorView.isHidden = false
                    self.connection = false
                    MBProgressHUD.hide(for: self.tableView, animated: true)
                } else {
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
                            MBProgressHUD.hide(for: self.tableView, animated: true)
                            self.connection = true
                            self.networkErrorView.isHidden = true
                            self.tableView.reloadData()
                        }
                    }
                }
        })
        
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
        
        task.resume()
    }
}
