//
//  ViewController.swift
//  FrienlyChat
//
//  Created by anmol rattan on 28/07/21.
//

import UIKit
import Firebase
import FirebaseAuthUI



class FCViewController: UIViewController {
    
    
    //MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    var ref:DatabaseReference!
    fileprivate var _refHandle:DatabaseHandle!
   
    var user:User?
    var messages:[DataSnapshot] = []{
        didSet{
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureDatabase()
        
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 122.0
        
    }
    
    
    
    @IBAction func cameraBtnAction(_ sender: UIButton) {
    }
    
    
    @IBAction func sendBtnAction(_ sender: UIButton) {
        self.sendMessage()
    }
    
    
    
    func configureDatabase(){
        ref = Firebase.Database.database().reference()
        _refHandle = ref.child("Messages").observe(.childAdded){ snapshot in
            self.messages.append(snapshot)
        }
        
    }
    
    
    deinit {
        ref.child("Messages").removeObserver(withHandle: _refHandle)
    }
    
    func sendMessage(){
        guard let message = messageField.text else{return}
        var data = [Constants.MessageFields.text:message]
        data[Constants.MessageFields.name] = user?.displayName
        ref.child("Messages").childByAutoId().setValue(data)
        
    }
    
    

}

