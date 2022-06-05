//
//  APODDetailView.swift
//  APODViaNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import SwiftUI

struct APODDetailView: View {
    @ObservedObject var apod: ApodResponse
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                        apod.isFavourite.toggle()
                        }) {
                        if apod.isFavourite {
                            
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                                
                        } else {
                            Image(systemName: "star")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray)
                        }
                    }
            }
            Spacer()
            LazyImage(imageUrl: apod.url).frame(width: 200, height: 200, alignment: .center)
            Text(apod.explanation)
            Spacer()
        }.padding()
        .navigationBarTitle(Text(apod.title), displayMode: .inline)
    }
    
    func test() {
        
    }
}

//struct APODDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        APODDetailView(apod: ApodResponse(date: "01-01-2020", title: "Distorted Green Flash Sunset over Italy", explanation: "This was one strange sunset. For one thing, the typically round Sun appeared distorted, geometrically, and multiply layered. For another, some of these layers appeared unusually green. The Sun, of course, was just fine -- its odd appearance was caused entirely by its light refracting in the Earth's atmosphere. When layers of the Earth's atmosphere are unusually warm, layers of the Sun may appear distorted or even seen multiple times. The effect is most strong nearest sunrise and sunset when terrestrial inversion layers occupy distinct altitudes above the horizon. Different colors of the Sun may also become deflected by significantly different amounts, so that the uppermost superior image may appear momentarily green -- a phenomenon known as a green flash. The featured image was taken in February from Porto Venere, Italy, with San Pietro church situated in the foreground.   Follow APOD on: Facebook,  Google Plus, or Twitter", url: "calender", media_type: ""))
//    }
//}
