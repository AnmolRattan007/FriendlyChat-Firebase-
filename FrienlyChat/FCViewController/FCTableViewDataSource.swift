//
//  FCTableViewDataSource.swift
//  FrienlyChat
//
//  Created by anmol rattan on 31/07/21.
//

import Foundation
import UIKit
import FirebaseStorage
fileprivate let FCCellReuseIdentifier = "messageCell"
extension FCViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FCCellReuseIdentifier, for: indexPath) as? MessagesTableViewCell
        else{return UITableViewCell()}
        
        
        cell.photo.image = UIImage(systemName: "ic_account_circle.png")
        if let messageData = messages[indexPath.row].value as? [String:String]{
           
            if let imageURL = messageData[Constants.MessageFields.imageUrl]{
                Storage.storage().reference(forURL: imageURL).getData(maxSize: INT64_MAX){
                    (data,error) in
                    guard error == nil else{
                        print("Error in downloading: \(error!)")
                        return
                    }
                    //DisplayImage
                    let messageImage = UIImage.init(data: data!,scale: 50)
                    
                    if cell == tableView.cellForRow(at: indexPath){
                        
                        DispatchQueue.main.async {
                            cell.imageView?.image = messageImage
                            cell.setNeedsLayout()
                        }
                    }
                }
                
                
            }else{
                let message = messageData[Constants.MessageFields.text] ?? ""
                let name = messageData[Constants.MessageFields.name] ?? ""
                cell.message.text = name + ": " + message
               
            }
        }
        return cell
    }
    
    
    
    
}
