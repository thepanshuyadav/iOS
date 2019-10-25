//
//  Map.swift
//  Landmarks
//
//  Created by Deepanshu Yadav on 17/10/19.
//  Copyright © 2019 Deepanshu Yadav. All rights reserved.
//

import SwiftUI
import MapKit

struct Map: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var landmark: Landmark
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {

        let span = MKCoordinateSpan(latitudeDelta: 0.020, longitudeDelta: 0.020)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.mapType = MKMapType.satellite
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = landmark.name
        uiView.addAnnotation(annotation)
        uiView.setRegion(region, animated: true)
        
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map(coordinate: landmarkData[0].locationCoordinate,landmark: landmarkData[0])
    }
}
