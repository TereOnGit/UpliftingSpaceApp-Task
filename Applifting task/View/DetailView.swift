import SwiftUI

struct DetailView: View {
    var launch: Launch
    
    var body: some View {
        ZStack {
            Image("space2")
                .resizable()
                .scaledToFill()
                .frame(width: 500, height: 900)
            VStack(spacing: 10) {
                Text(launch.name)
                    .font(.system(size: 50, weight: .bold))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
                if let detail = launch.details {
                    Text(detail)
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                } else {
                    Text("The details for this launch are not available at the moment.")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                }
            }
            .frame(width: 400, height: 700)
            .padding()
        }
        .ignoresSafeArea()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(launch: .launchWithoutDetails)
        DetailView(launch: .launchWithDetails)
    }
}
