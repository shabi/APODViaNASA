//
//  LazyImage.swift
//  APODViaNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import SwiftUI
import UIKit


struct LazyImage: View {
    static var defaultImage: UIImage = UIImage(named: "no-image-icon")!
    @ObservedObject var imageDownloader: ImageDownloader
    
    init(imageUrl: String) {
        imageDownloader = ImageDownloader(imageUrl: imageUrl)
    }
    
    var body: some View {
        VStack {
            Image(uiImage: imageDownloader.downloadedImage ??  LazyImage.defaultImage)
                .resizable()
                .scaledToFit()
        }
    }
}

struct LazyImage_Previews: PreviewProvider {
    static var previews: some View {
        LazyImage(imageUrl: "")
    }
}
