//
//  NASA APOD.swift
//  APODViaNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import SwiftUI

struct NASA_APOD: View {
//    let apodList = BundleDecoder.decodeApodjson()
    @ObservedObject var apodHomeViewModel: ApodHomeViewModel = ApodHomeViewModel()
    @State private var startDateSelected: Date = Date()
    @State private var endDateSelected: Date = Date()
    @State private var isalertPresented: Bool = false
    
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    var body: some View {
        
        
        NavigationView {            
            ZStack {
                
                    
                
                VStack {
                    HStack {
                        Text("NASA’s Astronomy picture of the day")
                        Spacer()
                    }.padding()
                    
                    
                    VStack {
                        DatePicker("Select start date", selection: $startDateSelected, in: ...startDate, displayedComponents:[.date])
                        DatePicker("Select end date", selection: $endDateSelected, in: ...endDate, displayedComponents:[.date])
                    }
                    .accentColor(Color.red)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            if startDateSelected > endDateSelected {
                                self.isalertPresented.toggle()
                            } else {
                                apodHomeViewModel.callApodApi(startDate: startDateSelected, endDate: endDateSelected)
                            }
                            
                        }, label: {
                            Text("Click here to search")
                        }).padding(8)
                        .background(Color.green)
                        .cornerRadius(8)
                        .alert(isPresented: $isalertPresented, content: {
                            Alert(title: Text("Start date cannot be after End date"), message: nil, dismissButton: .cancel())
                        })
                        
                    }.padding()
                    
                    
                    List {
                        ForEach(apodHomeViewModel.apods, id: \.title) { apod in
                            NavigationLink(
                                destination: APODDetailView(apod: apod),
                                label: {
                                    ApodRow(apod: apod)
                                })

                        }
                    }.navigationBarTitle("NASA’s")
                }
                
                LoaderView(tintColor: .red, scaleSize: 3.0, apodHomeViewModel: apodHomeViewModel).hidden(false)
            }
            
            
            
        }.onAppear(perform: {
            debugPrint("onAppear")
            apodHomeViewModel.callApodApi(queryDate: Date())
        })
    }
}

struct NASA_APOD_Previews: PreviewProvider {
    static var previews: some View {
        NASA_APOD()
    }
}
