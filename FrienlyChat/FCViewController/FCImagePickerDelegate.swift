//
//  FCImagePickerDelegate.swift
//  FrienlyChat
//
//  Created by anmol rattan on 31/07/21.
//

import Foundation
import UIKit

extension FCViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let photoData = photo.jpegData(compressionQuality: 0.8){
            self.sendPhotoMessage(photoData: photoData)
            
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
