//
//  FCTableViewDelegate.swift
//  FrienlyChat
//
//  Created by anmol rattan on 31/07/21.
//

import Foundation
import UIKit

extension FCViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
