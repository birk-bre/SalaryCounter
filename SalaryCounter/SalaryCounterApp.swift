//
//  SalaryCounterApp.swift
//  SalaryCounter
//
//  Created by Birk Eidsvik on 05/10/2023.
//

import SwiftUI


class Counter: ObservableObject {
    @Published var sum = 0.0;
    @Published var salary = 0.0;
    @Published var isCounting = false
    
    private var timer: Timer?
    private var timeInterval =  5.0
    
    func startCounter(){
        self.sum = 0
        self.isCounting = true
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { _ in
            let ratePerSecond = self.salary / 3600.0
            print("INCREMENTING \(ratePerSecond) \(self.salary)")

            self.sum += ratePerSecond * self.timeInterval
        })
    }
    
    func stopCounter(){
        timer?.invalidate()
        self.isCounting = false
    }
    
    func setSalary(newSalary: Double) {
        salary = newSalary
    }
}

@main
struct SalaryCounterApp: App {
    @StateObject var counter = Counter()
    @State private var incrementText: String = ""
    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        MenuBarExtra("Earned so far \(counter.sum.formatted(.number.precision(.fractionLength(0))))kr") {
            VStack{
                HStack{
                    TextField("Your hourly rate", text: $incrementText)
                        .onSubmit {
                            if let intValue = Double(incrementText) {
                                counter.setSalary(newSalary: intValue)
                                counter.startCounter()
                            }
                        }
                        .padding(5.0)
                    Button("Submit and start") {
                        if let intValue = Double(incrementText) {
                            counter.setSalary(newSalary: intValue)
                            counter.startCounter()
                        }
                    }
                }
       
                
                Button("Start") {
                    counter.startCounter()
                }
                
                Button("Stop") {
                    counter.stopCounter()
                }
            }.padding()

        }
        .menuBarExtraStyle(.window)
        
        
    }
}
