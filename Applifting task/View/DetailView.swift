import SwiftUI

struct DetailView: View {
    var launch: Launch 
    
    var body: some View {
        VStack {
            Image("rocket")
            Text(launch.name)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
            if let detail = launch.details {
                Text(detail)
                    .foregroundColor(.white)
            } else {
                Text("The details for this launch are not available at the moment.")
                    .foregroundColor(.white)
            }
        }
        .background(
            Image("space")
                .resizable()
                .opacity(0.5))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(launch: .launchWithoutDetails)
        DetailView(launch: .launchWithDetails)
    }
}
