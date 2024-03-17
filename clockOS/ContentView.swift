//
//  ContentView.swift
//  clockOS
//
//  Created by Muhammad Rafi on 17/03/24.
//

import SwiftUI

struct City {
    let name: String
    let timeZone: TimeZone
}

struct ContentView: View {
    @State private var cities = [
        City(name: "India", timeZone: TimeZone.current),
        City(name: "San Francisco", timeZone: TimeZone(identifier: "America/Los_Angeles")!),
        // Add more cities here
    ]
    
    var body: some View {
        VStack {
            Text("Digital Clock")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "747264")) // Change title color
                .padding(10)
            Spacer()
            ForEach(cities, id: \.name) { city in
                ClockView(city: city)
                    .padding(.bottom, 10)
            }
            Spacer()
        }
        .padding(70)
        .background(Color(hex: "E0CCBE")) // Set background color
        .edgesIgnoringSafeArea(.all)
    }
}

struct ClockView: View {
    let city: City
    @State private var time = Date()
    
    var body: some View {
        VStack {
            Text(city.name)
                .font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color(hex: "3C3633")) // Set text color
                .padding(.bottom, 5)
            Text(getTimeString())
                .font(.system(size: 46, weight: .bold, design: .monospaced))
                .foregroundColor(Color(hex: "747264")) // Set text color
        }
        .onAppear {
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.time = Date()
            }
            RunLoop.main.add(timer, forMode: .common)
        }
    }
    
    private func getTimeString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = city.timeZone
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: time)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#", into: nil)
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(.sRGB, red: red, green: green, blue: blue)
    }
}

