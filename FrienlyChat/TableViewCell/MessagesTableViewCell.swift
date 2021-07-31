//
//  MessagesTableViewCell.swift
//  FrienlyChat
//
//  Created by anmol rattan on 31/07/21.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
