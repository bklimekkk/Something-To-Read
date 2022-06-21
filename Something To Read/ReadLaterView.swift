//
//  ReadLaterView.swift
//  Something To Read
//
//  Created by Bartosz Klimek on 20/06/2022.
//

import SwiftUI

struct ReadLaterView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @FetchRequest(sortDescriptors: []) var savedBooks: FetchedResults<SavedBook>
    @Environment(\.managedObjectContext) var moc
    
    @State private var bookToShow: TheBook = TheBook(title: "", bookImage: "", author: "", description: "", buyLinks: []) 
 
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns){
                ForEach(savedBooks, id: \.title) { book in
                    
                    
                    NavigationLink{
                        DetailsView(fromReadingList: true, book: TheBook(title: book.wrappedTitle, bookImage: book.wrappedBookImage, author: book.wrappedAuthor, description: book.wrappedAbout, buyLinks: book.wrappedRelationship.map{BuyLink(name:$0.wrappedName, url:$0.wrappedUrl)}))
                    }label:{
                    AsyncImage(url: URL(string: book.wrappedBookImage)) { image in
                        image
                            .resizable()
                            .frame(width: 160, height: 230)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray)
                                .frame(width: 160, height: 230)
                            ProgressView()
                        }
                        
                    }
                    }
                    .buttonStyle(.plain)
                        
                    
                    
                    
                }
            }
            .navigationTitle("Reading list")
            .padding([.horizontal, .bottom, .top])
        }
    }
}

struct ReadLaterView_Previews: PreviewProvider {
    static var previews: some View {
        ReadLaterView()
    }
}
