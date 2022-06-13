//
//  ProfileViewController.swift
//  DicodingDasariOS
//
//  Created by Arga Hutama on 05/06/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var instagramLabel: UILabel!
    
    @IBAction func openInstagram(sender:UITapGestureRecognizer) {
        let urlString = "https://www.instagram.com/argahutama"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.makeRoundedRectangle(radius: 16)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.openInstagram))
        instagramLabel.isUserInteractionEnabled = true
        instagramLabel.addGestureRecognizer(tap)
    }
}
