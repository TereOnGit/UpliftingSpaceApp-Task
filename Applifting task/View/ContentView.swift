import SwiftUI

struct ContentView: View {
    @State var launch: [Launch] = []
    
    var body: some View {
        NavigationView {
            List(launch) {
                launch in
                NavigationLink(destination: { DetailView(launch: launch)
                }, label: {
                    Text(launch.name)
                })
            }
            .navigationTitle("List of all launches")
            .task {
                do {
                    self.launch = try await Network.getLaunches()
                } catch {
                    print(error)
                }
            }
        }
        .toolbar {
            Text("Button")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
