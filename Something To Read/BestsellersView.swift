//
//  BestsellersView.swift
//  Something To Read
//
//  Created by Bartosz Klimek on 20/06/2022.
//

import SwiftUI


struct BestsellersView: View {
    
    var author: String
    var authorIsOn: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var category: String
    @ObservedObject var books: AllBooks
    
    var filteredBooks: [TheBook] {
        if !authorIsOn || author == "" {
            return books.books
        } else {
            return books.books.filter{$0.author == author }
        }
    }
    var body: some View {
        
        if !books.books.isEmpty {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 7) {
                    ForEach(filteredBooks, id: \.title) { book in
                        
                        
                        
                        NavigationLink{
                            DetailsView(fromReadingList: false, book: book)
                        }label:{
                            AsyncImage(url: URL(string: book.bookImage)) { image in
                                image
                                    .resizable()
                                    .frame(width: 160, height: 230)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(5)
                                
                            } placeholder: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.gray)
                                        .frame(width: 160, height: 230)
                                        .padding(5)
                                    ProgressView()
                                }
                                
                            }
                        }
                        .buttonStyle(.plain)
                        
                        
                        
                        
                    }
                }
                .navigationTitle(category)
                .padding([.horizontal, .bottom])
            }
            
        } else {
            VStack {
                Spacer()
                Text("No results")
                    .font(.headline)
                Spacer()
            }
        }
    }
}

struct BestsellersView_Previews: PreviewProvider {
    static var previews: some View {
        BestsellersView(author: "", authorIsOn: false, category: "Hardcover Fiction", books: AllBooks())
    }
}
