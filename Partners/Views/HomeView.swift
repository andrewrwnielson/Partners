//
//  HomeView.swift
//  Partners
//
//  Created by Andrew Nielson on 8/7/24.
//

import SwiftUI
import MapKit
import TipKit

struct HomeView: View {
    @State private var isJournalPresented = false
    @State private var isLocationPresented = false

    var body: some View {
        ZStack {
            // Layer 1: Clock Section (Top)
            VStack(alignment: .center) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        VStack {
                            Text("Your Time")
                                .font(.title)
                                .bold()
                                .foregroundStyle(Color(hex: 0x152224))
                            
                            ClockView(difference: 0)
                                .frame(width: UIScreen.main.bounds.width * 0.6)
                                .padding(.horizontal, 80)
                                .shadow(radius: 10)
                        }
                        
                        ForEach(MockData.users) { user in
                            VStack {
                                Text(user.userName)
                                    .font(.title)
                                    .bold()
                                    .foregroundStyle(Color(hex: 0x152224))
                                
                                ClockViewForUser(user: user)
                                    .padding(.horizontal, 80)
                                    .shadow(radius: 10)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .zIndex(0) // Layer 1 (Top Layer)

            // Layer 2: Button Section (Bottom)
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                        .foregroundStyle(Color(hex: 0x6A8A7D))
                        .frame(height: UIScreen.main.bounds.height / 2)
                        .shadow(radius: 5)
                        .offset(y: 100)
                    
                    RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                        .stroke(lineWidth: 15)
                        .frame(height: UIScreen.main.bounds.height / 2)
                        .foregroundStyle(Color(hex: 0x152224))
                        .offset(y: 100)
                    
                    VStack(spacing: 20) {
                        // Top row (Join Group, Create Group)
                        HStack {
                            Button(action: {
                                // Join Group Action
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                                        .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 150)
                                        .foregroundStyle(Color(hex: 0x152224))
                                    
                                    VStack {
                                        Image("joinGroup")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 110)
                                        
                                        Spacer()
                                        
                                        Text("Join Group")
                                            .bold()
                                            .font(.title2)
                                    }
                                    .padding(20)
                                    .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 150)
                                    .foregroundStyle(Color(hex: 0xF6E9C7))
                                }
                            })
                            
                            Button(action: {
                                // Create Group Action
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                                        .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 150)
                                        .foregroundStyle(Color(hex: 0x152224))
                                    
                                    VStack {
                                        Image(systemName: "person.fill.badge.plus")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 75)
                                            .offset(x: 10)
                                        
                                        Spacer()
                                        
                                        Text("Create Group")
                                            .bold()
                                            .font(.system(size: 20))
                                    }
                                    .padding(20)
                                    .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 150)
                                    .foregroundStyle(Color(hex: 0xF6E9C7))
                                }
                            })
                        }
                        
                        // Bottom row (Journal, Map)
                        HStack {
                            Button(action: {
                                isJournalPresented = true
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                                        .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 150)
                                        .foregroundStyle(Color(hex: 0x152224))
                                    
                                    VStack {
                                        Image(systemName: "book.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 75)
                                        
                                        Spacer()
                                        
                                        Text("Journal")
                                            .bold()
                                            .font(.title2)
                                    }
                                    .padding(20)
                                    .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 150)
                                    .foregroundStyle(Color(hex: 0xF6E9C7))
                                }
                            })
                            
                            Button(action: {
                                isLocationPresented = true
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                                        .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 150)
                                        .foregroundStyle(Color(hex: 0x152224))
                                    
                                    VStack {
                                        Image(systemName: "globe.americas.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 75)
                                        
                                        Spacer()
                                        
                                        Text("Map")
                                            .bold()
                                            .font(.title2)
                                    }
                                    .padding(20)
                                    .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 150)
                                    .foregroundStyle(Color(hex: 0xF6E9C7))
                                }
                            })
                        }
                    }
                    .offset(y: 75)
                }
                .frame(height: UIScreen.main.bounds.height / 2)
            }
            .zIndex(1) // Layer 2 (Bottom Layer)
        }
        .background(Color(hex: 0xF6E9C7))
        .foregroundStyle(Color(hex: 0xF6E9C7))
        .fullScreenCover(isPresented: $isJournalPresented) {
            JournalView()
        }
        .fullScreenCover(isPresented: $isLocationPresented) {
            LocationView()
        }
    }
    
    func getTimeZoneDifference(location: CLLocationCoordinate2D, completion: @escaping ((Double) -> Void)) {
        let cllLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(cllLocation) { placemarks, error in

            if let error = error {
                print(error.localizedDescription)

            } else {
                if let placemarks = placemarks {
                    if let optTimeZone = placemarks.first!.timeZone {
                        let localTimeZone = TimeZone.current
                        let timeZoneDifference = Double(optTimeZone.secondsFromGMT() - localTimeZone.secondsFromGMT()) / 3600
                        completion(timeZoneDifference)
                    }
                }
            }
        }
    }
}


struct ClockViewForUser: View {
    let user: User
    @State private var timeZoneDifference: Double? = nil
    @State private var isLoading = true // Track loading state
    @State private var errorMessage: String? = nil // Track any errors

    var body: some View {
        VStack {
            if let difference = timeZoneDifference {
                ClockView(difference: difference)
                    .frame(width: UIScreen.main.bounds.width * 0.6)
            } else if let errorMessage = errorMessage {
                Text("Failed to load: \(errorMessage)")
                    .foregroundColor(.red)
                    .frame(width: UIScreen.main.bounds.width / 2.8, height: 100)
            } else if isLoading {
                Text("Loading...")
                    .frame(width: UIScreen.main.bounds.width / 2.8, height: 100)
            }
        }
        .onAppear {
            loadTimeZone()
        }
    }

    // Encapsulated function to load the time zone difference
    private func loadTimeZone() {
        isLoading = true
        errorMessage = nil

        HomeView().getTimeZoneDifference(location: user.location) { difference in
            DispatchQueue.main.async {
                self.timeZoneDifference = difference
                self.isLoading = false
            }
        }
    }
}

#Preview {
    HomeView()
}
