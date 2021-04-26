//
//  Extensions.swift
//  twitterUI
//
//  Created by GSS on 2021-04-25.
//

import Foundation
import UIKit
import MapKit


extension MKMapView {
    /* Display all the annotations in screen
     */
    func fitAll() {
        var zoomRect = MKMapRect.null;
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
            zoomRect = zoomRect.union(pointRect);
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
    }

}

extension String{
    /* Convert label to image
     */
    func getImageFromText() -> UIImage{
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.red
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.layer.cornerRadius = 10
        label.text = "\(String(describing: self.first!))".capitalized
        let image = UIImage().imageWithLabel(label: label)
        return image
    }
}


extension UIImage {
    /* Convert label to image
     */
     func imageWithLabel(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let image = UIImageView(image: img!).makeRoundImage()
        return image
   }
}



extension UIImageView {
    /* Make image round
     */
    func makeRoundImage() -> UIImage {
        let imgLayer = CALayer()
        imgLayer.frame = self.bounds
        imgLayer.contents = self.image?.cgImage;
        imgLayer.masksToBounds = true;

        imgLayer.cornerRadius = self.frame.size.width/2

        UIGraphicsBeginImageContext(self.bounds.size)
        imgLayer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage!
    }
   
}
