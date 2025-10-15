import SwiftUI

struct IntroView: View {
    var body: some View {
        
        NavigationView {
            VStack {
                Spacer()
                
                Image("intro")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                Spacer()
                // boton crear cuenta
                Button(action: {
                    print("Boton crear cuenta presionado")
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
                
                // boton conectarse
                NavigationLink(destination: HomeView()) {
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
            .edgesIgnoringSafeArea(.top)
            .background(Color.white)
            // ocultar barra de navegacion
            .navigationBarHidden(true)
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
