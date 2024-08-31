//
//  ClockView.swift
//  Partners
//
//  Created by Andrew Nielson on 8/7/24.
//

import SwiftUI

struct ClockView: View {
    @State private var currentTime = Date()
    let difference: Double
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let size = min(width, height)
            
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: currentTime) % 12
            let minute = calendar.component(.minute, from: currentTime)
            let hourAngle = Angle.degrees((Double(hour) + difference) * 30 + Double(minute) * 0.5)
            
            VStack {
                ZStack {
                    Circle()
                        .foregroundStyle(Color(hex: 0x6A8A7D))
                    
                    Circle()
                        .stroke(lineWidth: 6)
                        .foregroundStyle(Color(hex: 0x152224))
                        .overlay(
                            ForEach(0..<12) { i in
                                Rectangle()
                                    .fill(Color(hex: 0x152224))
                                    .frame(width: 7, height: 16)
                                    .offset(y: -size / 2 + 6)
                                    .rotationEffect(.degrees(Double(i) * 30))
                            }
                        )
                    
                    Rectangle()
                        .fill(Color(hex: 0xE62013))
                        .frame(width: 7, height: size * 0.25)
                        .offset(y: -size * -0.125)
                        .rotationEffect(hourAngle + Angle.degrees(180))
                    
                    let minuteAngle = Angle.degrees(Double(minute) * 6)
                    
                    Rectangle()
                        .fill(Color(hex: 0xE62013))
                        .frame(width: 2.5, height: size * 0.35)
                        .offset(y: -size * -0.175)
                        .rotationEffect(minuteAngle + Angle.degrees(180))
                    
                    Circle()
                        .fill(Color(hex: 0x152224))
                        .frame(width: 12.5)
                }
                
                VStack(spacing: 5) {
                    Text(currentTime + difference * 3600, style: .time)
                        .font(.custom("digital-7", size: 36))
                    
                    Rectangle()
                        .frame(width: 100, height: 2)
                        .foregroundStyle(Color(hex: 0xE62013))
                    
                    Text(currentTime + difference * 3600, style: .date)
                        .font(.system(size: 16))
                }
                .foregroundStyle(Color(hex: 0x152224))
            }
        }
        .onAppear(perform: startTimer)
    }
    
    func startTimer() {
        let calendar = Calendar.current
        let now = Date()
        let nextMinute = calendar.nextDate(after: now, matching: DateComponents(second: 0), matchingPolicy: .nextTime)!
        let interval = nextMinute.timeIntervalSince(now)
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            self.currentTime = Date()
            Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
                self.currentTime = Date()
            }
        }
    }
}

#Preview {
    ClockView(difference: 0.0)
}

