//
//  MapView.swift
//  Partners
//
//  Created by Andrew Nielson on 8/15/24.
//

import SwiftUI
import MapKit


struct MapView: View {
    @StateObject var viewModel = MapViewModel()

    var body: some View {
        VStack {
            Map(coordinateRegion: viewModel.binding, showsUserLocation: true, annotationItems: MockData.posts) { post in
                MapMarker(coordinate: post.coordinates, tint: .red)
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                viewModel.checkIfLocationIsEnabled()
            }
        }
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?

    @Published var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43.457105, longitude: -80.508361),
        span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100) // Zoomed-out view
    )
    
    @Published var isMapCenteredOnUser = false // Flag to prevent snapping after initial centering

    var binding: Binding<MKCoordinateRegion> {
        Binding {
            self.mapRegion
        } set: { newRegion in
            self.mapRegion = newRegion
        }
    }

    func checkIfLocationIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
            locationManager?.startUpdatingLocation()  // Start location updates
        } else {
            print("Show an alert letting them know location services are off.")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        // Only center on the user's location the first time
        if !isMapCenteredOnUser {
            DispatchQueue.main.async {
                // Set a large span for a zoomed-out view, but center on the user's location
                self.mapRegion = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100) // World/continent zoom level
                )
                self.isMapCenteredOnUser = true // Prevent further automatic updates
            }
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let previousAuthorizationStatus = manager.authorizationStatus
        manager.requestWhenInUseAuthorization()
        if manager.authorizationStatus != previousAuthorizationStatus {
            checkLocationAuthorization()
        }
    }

    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Location permission denied.")
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation() // Start location updates when permission is granted
        default:
            break
        }
    }
}


#Preview {
    MapView()
}
