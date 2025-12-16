import SwiftUI

struct IntroView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(systemName: "film.stack.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .foregroundColor(.blue)
                
                Text("Bienvenido a Cine ISIL")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                
                Text("Encuentra información de todas tus películas favoritas.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                NavigationLink(destination: MainView().navigationBarBackButtonHidden(true)) {
                    Text("Ingresar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}
