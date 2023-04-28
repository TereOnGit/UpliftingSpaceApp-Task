import SwiftUI

struct DetailView: View {
    var launch: Launch
    
    private func formattedDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d. M. yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm:ss"
        return dateFormatter.string(from: launch.dateUnix) + " at " + timeFormatter.string(from: launch.dateUnix)
    }
    
    var body: some View {
        ZStack {
            Image("space2")
                .resizable()
                .scaledToFill()
                .frame(width: 450, height: 900)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text(launch.name)
                    .font(.system(size: 50, weight: .bold))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.3)
                
                Buttons(launch: launch)
                
                Spacer()
                
                VStack {
                    Text("Launched:")
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("\(formattedDay())")
                }
                .font(.system(size: 25))
                .foregroundColor(.white)
                
                ScrollView {
                    if let detail = launch.details {
                        Text("Here are some details:")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold))
                        Spacer()
                        Text(detail)
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                    } else {
                        Text("Oops! Looks like the details for this launch are not available at the moment! But check it out later.")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .frame(maxWidth: .infinity)
                    }
                }
                .multilineTextAlignment(.center)
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
