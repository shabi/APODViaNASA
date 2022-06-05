//
//  ImageDownloader.swift
//  APODViaNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import Foundation
import UIKit

extension UIImage {
    
    func resizeImage(with size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: .zero, size: size))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage
        
    }
}

class ImageDownloader: ObservableObject {
    @Published var downloadedImage: UIImage?
    private let imagePath: URL
        
    init(imageUrl: String) {
        self.imagePath = URL(string: imageUrl)!
        getImage()
    }
    
    func getImage() {
        //Image Caching for offline support
        if let cachedImage = Constants.imageCache.object(forKey: self.imagePath as AnyObject) {
            debugPrint("Image fetched from Cached")
            self.downloadedImage = cachedImage
            return
        }
        
        var request = URLRequest(url: self.imagePath)
        request.httpMethod = "get"
        URLSession.shared.dataTask(with: request) {[weak self] (imageData, response, err) in
            if err == nil && imageData != nil {
                DispatchQueue.main.async {
                    //Optimizing image size for data
                    let image = UIImage(data: imageData!)?.resizeImage(with: CGSize(width: 50, height: 50))
                    self?.downloadedImage = image
                    if let imageValue = image {
                        debugPrint("Image fetched from Server")
                        Constants.imageCache.setObject(imageValue, forKey: self?.imagePath as AnyObject)
                    }
                }
            }
        }.resume()
    }
    
}
