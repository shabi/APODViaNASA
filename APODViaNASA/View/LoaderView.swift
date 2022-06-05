//
//  LoaderView.swift
//  APODViaNASA
//
//  Created by Shabi Naqvi on 05/06/22.
//

import SwiftUI

struct LoaderView: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    @ObservedObject var apodHomeViewModel: ApodHomeViewModel
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

extension LoaderView {
    
    @ViewBuilder func hidden(_ shouldHide: Bool)-> some View {
        switch !apodHomeViewModel.isLoading {
        case true:self.hidden()
        case false:self
        }
    }
}
