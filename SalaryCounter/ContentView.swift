//
//  ContentView.swift
//  SalaryCounter
//
//  Created by Birk Eidsvik on 05/10/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true

    var body: some View {
        Toggle(isOn: $showMenuBarExtra, label: {
            Text("Always show menu")
        })
        .toggleStyle(.switch)
        
    }
}

#Preview {
    ContentView()
}
