import SwiftUI

struct DetailView: View {
    var launch: Launch
    
    var body: some View {
        ZStack {
            Image("space2")
                .resizable()
                .scaledToFill()
                .frame(width: 500, height: 900)
                .ignoresSafeArea()
            VStack(spacing: 10) {
                Text(launch.name)
                    .font(.system(size: 50, weight: .bold))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Buttons(launch: launch)
                ScrollView {
                    if let detail = launch.details {
                        Text("Here are some details:")
                            .foregroundColor(.white)
                            .font(.system(size: 35, weight: .bold))
                            .multilineTextAlignment(.center)
                        Spacer()
                        Text(detail)
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                    } else {
                        Text("Oops! Looks like the details for this launch are not available at the moment! But check it out later.")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                    }
                }
                .multilineTextAlignment(.leading)
                .lineSpacing(10)
                .padding(.all, 40)
                
            }
            .padding(.vertical, 40)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(launch: .launchWithoutDetails)
        DetailView(launch: .launchWithDetails)
    }
}
