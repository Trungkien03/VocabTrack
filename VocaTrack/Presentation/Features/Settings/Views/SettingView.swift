//
//  SettingView.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import SwiftUI

struct SettingView: View {
    @State private var notificationsEnabled = true
    @State private var learningLanguage = "English"
    @State private var interfaceLanguage = "English"

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General Settings")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    Picker("Learning Language", selection: $learningLanguage) {
                        Text("English").tag("English")
                        Text("French").tag("French")
                        Text("Spanish").tag("Spanish")
                    }
                    Picker("Interface Language", selection: $interfaceLanguage) {
                        Text("English").tag("English")
                        Text("French").tag("French")
                        Text("Spanish").tag("Spanish")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingView()
}
