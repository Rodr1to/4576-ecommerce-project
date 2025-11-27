import SwiftUI

struct IntroView: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(systemName: "bag.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .foregroundColor(.blue)
                
                Text("Bienvenido a ISIL Shop")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                
                Spacer()
                
                Button(action: {
                    print("Crear cuenta presionado")
                }) {
                    Text("Crear cuenta")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                
                NavigationLink(destination: MainView().navigationBarBackButtonHidden(true)) {
                    Text("Conectarse")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                
                Spacer().frame(height: 50)
            }
            .padding()
        }
    }
}
