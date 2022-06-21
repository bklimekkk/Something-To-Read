//
//  FilterView.swift
//  Something To Read
//
//  Created by Bartosz Klimek on 21/06/2022.
//

import SwiftUI

class AllBooks: ObservableObject, Codable {
    @Published var books: [TheBook]
    
    enum CodingKeys: CodingKey {
        case books
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(books, forKey: .books)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        books = try container.decode([TheBook].self, forKey: .books)
    }
    init(){
        books = []
    }
}

class FilterSettings: ObservableObject {
    @Published var author: String = ""
    @Published var authorIsOn: Bool = false
    
}

struct FilterView: View {
    var dateString: String
    var category: String
    @StateObject private var filterSettings = FilterSettings()
    @StateObject private var books = AllBooks()
    
    var body: some View {
        Form {
            
            
            Section(header: Text("Author")) {
                Toggle("Specify author", isOn: $filterSettings.authorIsOn)
            }
            
            if filterSettings.authorIsOn {
                
                Section(header: Text("Author")) {
                    if !books.books.isEmpty {
                        Picker("Choose author", selection: $filterSettings.author) {
                            ForEach(Array(Set((books.books.map{$0.author}))), id: \.self) {
                                Text($0)
                            }
                            
                            
                        }
                        .pickerStyle(.menu)
                        .foregroundColor(.black)
                        
                        
                    } else {
                        Text("No authors")
                            .font(.headline)
                    }
                }
                
                
                
            }
            
            
            
            NavigationLink{
                BestsellersView(author: filterSettings.author, authorIsOn: filterSettings.authorIsOn, category: category, books: books)
            }label:{
                Button("Search results") {}
            }
        }
        .task {
            await loadBooks()
        }
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func loadBooks() async {
        print("DATE STRING: \(dateString)")
        guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/\(dateString)/\(category.components(separatedBy: .whitespaces).joined(separator: "-")).json?api-key=omQdyherKGA4AE4xuE02mHyI0vbwa3Qe") else {
            print("Invalid url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let decodedData = try? decoder.decode(Book.self, from: data) {
                books.books = decodedData.results.books
            }
        } catch {
            print("Invalid data")
        }
        
        
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(dateString: "2008-04-13", category: "E-Book Fiction")
    }
}
