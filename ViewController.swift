//
//  ViewController.swift
//  IOSWeek13
//
//  Created by admin on 18/06/2020.
//  Copyright © 2020 Fred. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var myImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myImage.image = #imageLiteral(resourceName: "cat")
        
    
    }
    @IBAction func largeImage(_ sender: Any) {
        let size = CGSize(width: 500, height: 1000)
        myImage.image = resizeImage(image: myImage.image!, targetSize: size)
        
    }
    @IBAction func addTextButton(_ sender: Any) {
        
        let textToDraw = textField.text
        let point = CGPoint(x:20,y:2)
        
        myImage.image = textToImage(drawText: textToDraw!, inImage: myImage.image!, atPoint: point)
    }
    @IBAction func smalImage(_ sender: Any) {
        
        let size = CGSize(width: 150, height: 300)
        myImage.image = resizeImage(image: myImage.image!, targetSize: size)
            
    }
    
    @IBAction func mediumImage(_ sender: Any) {
        let size = CGSize(width: 200, height: 500)
        myImage.image = resizeImage(image: myImage.image!, targetSize: size)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 12)!

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
}

