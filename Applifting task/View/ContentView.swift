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
                print(error)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
