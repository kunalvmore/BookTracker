//
//  ContentView.swift
//  BookTracker
//
//  Created by Kunal More on 15/04/24.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Book.title) private var books: [Book]
    @State private var createNewBook = false
    var body: some View {
        NavigationStack {
            Group {
                if books.isEmpty {
                    ContentUnavailableView("Enter you first book.", systemImage: "book.fill")
                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink {
                                Text(book.title)
                            } label: {
                                HStack(spacing: 10) {
                                    book.icon
                                    VStack(alignment: .leading) {
                                        Text(book.title).font(.title2)
                                        Text(book.author).foregroundStyle(.secondary)
                                        
                                    }
                                }
                            }
                            
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let book = books[index]
                                context.delete(book)
                            }
                            
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Books List")
            .toolbar {
                Button {
                    createNewBook = true
                }label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $createNewBook) {
                NewBookView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    BookListView()
        .modelContainer(for: Book.self, inMemory: true)
}
