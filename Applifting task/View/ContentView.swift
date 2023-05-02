import SwiftUI

struct ContentView: View {
    enum SortOption: Int {
        case aToZ, earliest, latest
    }
    
    @AppStorage("sortOption") private var sortOption: SortOption?
    
    @State var launches: [Launch] = []
    @State private var searchText = ""
    @State private var showAlert = false
    @State private var showActionSheet = false
    
    private var searchedResults: [Launch] {
        if searchText.isEmpty {
            return sortedLaunches
        } else {
            return sortedLaunches.filter { launch in
                launch.name.contains(searchText)
            }
        }
    }
    
    private var sortedLaunches: [Launch] {
        switch sortOption {
        case .aToZ:
            return launches.sorted(by: { $0.name < $1.name })
        case .earliest:
            return launches.sorted(by: { $0.dateUnix < $1.dateUnix })
        case .latest:
            return launches.sorted(by: { $0.dateUnix > $1.dateUnix })
        case nil:
            return launches
        }
    }
    
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
            await loadData()
        }
        .refreshable {
            await loadData()
        }
        
        .alert("Launches cannot be loaded. Please, check your internet connection and try again.", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
        
        .actionSheet(isPresented: $showActionSheet, content: {
            ActionSheet(title: Text("Sort by:"),
                        buttons: [
                            .default(Text("Name from A to Z").foregroundColor(Color("spaceBlue"))) {
                                self.sortOption = .aToZ
                            },
                            .default(Text("Date from earliest")) {
                                self.sortOption = .earliest
                            },
                            .default(Text("Date from latest")) {
                                self.sortOption = .latest
                            },
                            .cancel()
                        ])
        })
    }
    
    func loadData() async {
        do {
            self.launches = try await Network.getLaunches()
        } catch {
            showAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
