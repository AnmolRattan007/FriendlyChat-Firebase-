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
    var imagePicker:UIImagePickerController!
    var storageRefrence:StorageReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForKeyboardNotification()
        configureTableView()
        configureDatabase()
        configureStorage()
        
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 122.0
        
    }
    
    
    
    @IBAction func cameraBtnAction(_ sender: UIButton) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    
        
    }
    
    
    @IBAction func sendBtnAction(_ sender: UIButton) {
        guard let message = messageField.text else{return}
        var data = [Constants.MessageFields.text:message]
        data[Constants.MessageFields.name] = user?.displayName
        self.sendMessage(data: data)
    }
    
    
    
    func configureDatabase(){
        ref = Firebase.Database.database().reference()
        _refHandle = ref.child("Messages").observe(.childAdded){ snapshot in
            self.messages.append(snapshot)
        }
        
    }
    
    func configureStorage(){
        
        storageRefrence = Storage.storage().reference()
        
    }
    
    
    deinit {
        ref.child("Messages").removeObserver(withHandle: _refHandle)
        unsubscribeFromAllNotifications()
    }
    
    func sendMessage(data:[String:String]){
        ref.child("Messages").childByAutoId().setValue(data)
        
    }
    
    func sendPhotoMessage(photoData:Data){
        let imagePath = "chat_photos/" + user!.uid + "/\(Double(Date.timeIntervalSinceReferenceDate*1000)).jpeg"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        storageRefrence.child(imagePath).putData(photoData, metadata: metaData){(metadata,error) in
            
            if let error = error{
                print("error uploading: \(error)")
                return
            }
            let data = [Constants.MessageFields.imageUrl:self.storageRefrence.child((metadata?.path)!).description]
            self.sendMessage(data: data)
            
        }
    }
    
    
    
    func subscribeForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func  unsubscribeFromAllNotifications(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}

