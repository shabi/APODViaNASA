//
//  ApodRow.swift
//  APODViaNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import SwiftUI

struct ApodRow: View {
    
    @ObservedObject var apod: ApodResponse
    
    var body: some View {
        HStack{
            LazyImage(imageUrl: apod.url)
                .frame(width: 50, height: 50, alignment: .center)
            Text(apod.title)
            Spacer()
            if apod.isFavourite {
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            } else {
                Image(systemName: "star")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ApodRow_Previews: PreviewProvider {
    static var previews: some View {
        ApodRow(apod: ApodResponse( date: "01-01-2020", title: "Hello", explanation: "Hello", url: "calender", media_type: "image"))
    }
}
