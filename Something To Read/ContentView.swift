//
//  ContentView.swift
//  Something To Read
//
//  Created by Bartosz Klimek on 20/06/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var categories: [String] = []
    
    var filteredCategories: [String] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter{return $0.lowercased().contains(searchText.lowercased())}
        }
    }
    var body: some View {
 
        NavigationView {
            List {
                    ForEach(filteredCategories, id: \.self) { category in
                        NavigationLink{
                            DateView(category: category)
                        }label:{
                            Text(category)
                        }
                       
                    }
                }

            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink{
                        ReadLaterView()
                    }label:{
                        Text("Reading List")
                    }
                }
            }
                .navigationTitle("Something To Read")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText)
                .task {
                    await loadCategories()
            }
        }
    }
    
    func loadCategories() async {
        guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=omQdyherKGA4AE4xuE02mHyI0vbwa3Qe") else {
            print("Invalid url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let decodedData = try? decoder.decode(Category.self, from: data) {
                categories = decodedData.results.map{$0.listName}
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
