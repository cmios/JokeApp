//
//  JokeViewTbl.swift
//  DailyJoke
//
//  Created by CM on 29/06/23.
//

import Foundation
import UIKit

extension JokeViewController: UITableViewDataSource ,UITableViewDelegate{
    
    //MARK:UITableView Datasource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return arrJokes.arrJokeMsg.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      cell.textLabel?.numberOfLines = 0
      cell.textLabel?.text = arrJokes.arrJokeMsg[indexPath.row]
      if indexPath.row == arrJokes.arrJokeMsg.count-1{
          cell.textLabel?.textColor = .black
      }else{
          cell.textLabel?.textColor = .lightGray
      }
    return cell
  }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewH = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50))
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50))
        lblTitle.text = " Latest Jokes😛"
        lblTitle.font = UIFont.systemFont(ofSize: 25)
        lblTitle.textAlignment = .center
        viewH.addSubview(lblTitle)
        return viewH
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
