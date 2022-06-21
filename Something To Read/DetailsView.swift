//
//  DetailsView.swift
//  Something To Read
//
//  Created by Bartosz Klimek on 20/06/2022.
//

import SwiftUI

struct DetailsView: View {
    
    var fromReadingList: Bool
    @FetchRequest(sortDescriptors: []) var savedBooks: FetchedResults<SavedBook>
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    var alreadySaved: Bool {
        savedBooks.map{$0.wrappedTitle}.contains(book.title)
    }
    
    var book: TheBook
    var body: some View {
        
        
        
        ZStack {
            AsyncImage(url: URL(string: book.bookImage)) { image in
                image
                    .resizable()
            } placeholder: {}
            Form {
                
                
                
                
                Section(header: Text("Author")) {
                    
                    Text("Author: \(book.author)")
                }
                
                Section(header: Text("Description")) {
                    Text(book.description)
                }
                
                
                
                ForEach(book.buyLinks, id: \.name) { store in
                    Button {
                        if let url = URL(string: store.url) {
                            UIApplication.shared.open(url)
                        }
                    }label:{
                        Text("Buy on \(store.name)")
                    }
                    .buttonStyle(.plain)
                }
                
                
                Section {
                    Button {
                        
                        if alreadySaved {
                            for i in savedBooks {
                                if i.title == book.title {
                                    moc.delete(i)
                                  
                                    if fromReadingList {
                                        dismiss()
                                    }
                                }
                            }
                        } else {
                            let savedBook = SavedBook(context: moc)
                            savedBook.title = book.title
                            savedBook.author = book.author
                            savedBook.about = book.description
                            savedBook.bookImage = book.bookImage
                            
                            for i in book.buyLinks {
                                let savedBuyLink = SavedBuyLink(context: moc)
                                savedBuyLink.name = i.name
                                savedBuyLink.url = i.url
                                savedBuyLink.origin = savedBook
                            }
                         }
                        
                        if moc.hasChanges {
                            try? moc.save()
                        }
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    }label: {
                        Text(alreadySaved ? "Delete the book from the reading list" : "Add the book to the reading list")
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(alreadySaved ? .red : .blue)
                }
                
            }
            .navigationTitle(book.title)
        }
        
    }
}
