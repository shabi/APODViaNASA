//
//  ActivitiyIndicatorView.swift
//  APODViaNASA
//
//  Created by Shabi Naqvi on 05/06/22.
//

import Foundation
import UIKit
import SwiftUI

struct ActivitiyIndicatorView: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    @ObservedObject var apodHomeViewModel: ApodHomeViewModel
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        return activityIndicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        apodHomeViewModel.isLoading ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
