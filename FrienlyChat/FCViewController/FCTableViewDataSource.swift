//
//  FCTableViewDataSource.swift
//  FrienlyChat
//
//  Created by anmol rattan on 31/07/21.
//

import Foundation
import UIKit
fileprivate let FCCellReuseIdentifier = "messageCell"
extension FCViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FCCellReuseIdentifier, for: indexPath) as? MessagesTableViewCell
        else{return UITableViewCell()}
        if let messageData = messages[indexPath.row].value as? [String:String]{
            cell.name.text = messageData[Constants.MessageFields.name]
            cell.message.text = messageData[Constants.MessageFields.text]
        }
        return cell
    }
    
    
    
    
}
