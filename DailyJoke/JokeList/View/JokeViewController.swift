//
//  ViewController.swift
//  DailyJoke
//
//  Created by CM on 28/06/23.
//

import UIKit

class JokeViewController: UIViewController,JokeViewDelegates {
   
    var arrJokes = JokeModel(arrJokeMsg: [])
    var jkpresenter =  JokePresenter(apCall: ApiServiceClass())
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var jokeTimer:Timer?
    var actIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        safeArea = view.layoutMarginsGuide
        setupTableView()
        
        jkpresenter.JokeDelegetesSelf(jkSelf: self)
        jkpresenter.GetOldJoke()
        GetNewJoke()
        
        jokeTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(JokeUpdate(_tim:)), userInfo: nil, repeats: true)
        
        actIndicator.frame = self.view.frame
        self.tableView.addSubview(actIndicator)
        
        
    }
    
    //Timer Method called every minutes
    @objc func JokeUpdate(_tim:Timer){
        GetNewJoke()
        
    }
    
    //Get New joke from Api
    func GetNewJoke(){
        actIndicator.startAnimating()
        jkpresenter.GetNewJokes()
    }
    
    
    //Setup Table View UI
    func setupTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
      }
    

}

extension JokeViewController{
    
    //Called when new joke received
    func DisplayNewJoke(joke: JokeModel) {
        DispatchQueue.main.async {
            self.actIndicator.stopAnimating()
            self.arrJokes = joke
            self.tableView.reloadData()
        }
    }
    
    func DisplayError(strError: String){
        DispatchQueue.main.async {
            self.actIndicator.stopAnimating()
        let alert = UIAlertController(title: "Alert", message: strError, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
      }
    }
    
}

