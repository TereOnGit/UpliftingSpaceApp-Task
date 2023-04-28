import SwiftUI

struct ContentView: View {
    
    @State var launches: [Launch] = []
    @State private var searchText = ""
    
    private var searchedResults: [Launch] {
        if searchText.isEmpty {
            return launches
        } else {
            return launches.filter { launch in
                launch.name.contains(searchText)
            }
        }
    }
    
    @State private var showAlert = false
    @State private var showActionSheet = false
    
    var body: some View {
        NavigationView {
            List(searchedResults) { launch in
                NavigationLink(destination: { DetailView(launch: launch)
                }, label: {
                    Row(launch: launch)
                })
                    .navigationBarTitle("List of all launches")
                    .listRowBackground(Color("spaceLight"))
                    .listRowSeparatorTint(Color("spaceBlue"))
                    
            }
            .toolbar {
                Button {
                    showActionSheet = true
                } label: {
                    Text("Sort by")
                }
                .tint(.black)
            }
        }
        .searchable(text: $searchText)
        .task {
            do {
                self.launches = try await Network.getLaunches()
            } catch {
                showAlert = true
            }
        }
        .alert("Launches cannot be loaded. Please, check your internet connection and try again.", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
        .actionSheet(isPresented: $showActionSheet, content: {
            ActionSheet(title: Text("Sort by:"),
                        buttons: [
                            .default(Text("Name from A to Z")) {
                                self.launches = launches.sorted(by: { $0.name < $1.name })
                            },
                            .default(Text("Date from earliest")) {
                                self.launches = launches.sorted(by: { $0.dateUnix < $1.dateUnix })
                            },
                            .default(Text("Date from latest")) {
                                self.launches = launches.sorted(by: { $0.dateUnix > $1.dateUnix })
                            },
                            .cancel()
                        ])
                
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
