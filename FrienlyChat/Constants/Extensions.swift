//
//  Extensions.swift
//  FrienlyChat
//
//  Created by anmol rattan on 31/07/21.
//

import Foundation
import UIKit


private enum Storyboard:String{
    case main = "Main"
}
fileprivate extension UIStoryboard{
    
    static func loadFromMain(_ identifier:String)->UIViewController{
        return load(from: .main, identifier: identifier)
    }
    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }

}

extension UIStoryboard{
    
    class func loadFCViewController()->FCViewController{
        return loadFromMain(Constants.StoryboardIDs.FCViewControllerID) as! FCViewController
    }
    
}
