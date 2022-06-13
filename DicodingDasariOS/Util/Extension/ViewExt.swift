//
//  ViewExt.swift
//  DicodingDasariOS
//
//  Created by Arga Hutama on 05/06/22.
//

import UIKit

extension UIImageView {
    
    func loadImageFromServer(urlString: String) {
        URLSession.shared.dataTask(
            with: NSURL(string: urlString)! as URL,
            completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print(error ?? "No Error")
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    () -> Void in
                    let image = UIImage(data: data!)
                    self.image = image
                })
            }
        ).resume()
    }
    
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
    
    func makeRoundedRectangle(radius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
}
