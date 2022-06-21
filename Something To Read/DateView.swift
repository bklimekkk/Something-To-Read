//
//  FilterView.swift
//  Something To Read
//
//  Created by Bartosz Klimek on 20/06/2022.
//

import SwiftUI

class DateSettings: ObservableObject {
    @Published var date: Date = Date()
    @Published var dateIsOn: Bool = false
}

struct DateView: View {
    var category: String
    @StateObject private var dateSettings = DateSettings()
    
    var wrappedDateString: String {
        if dateSettings.dateIsOn {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: dateSettings.date)
            
        } else {
            return "current"
        }
    }

    var body: some View {
        Form {
            Section(header: Text("Date")) {
                Toggle("Specify date", isOn: $dateSettings.dateIsOn)
            }
            
           if dateSettings.dateIsOn {
                Section(header: Text("Date")) {
                    DatePicker("Enter date", selection: $dateSettings.date, in: ...Date.now, displayedComponents: .date)
                }
            }
            
            NavigationLink{
                FilterView(dateString: wrappedDateString, category: category)
            }label:{
                Button("Next") {}
            }
        }
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(category: "Hardcover Fiction")
    }
}
