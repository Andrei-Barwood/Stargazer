import SwiftUI

/// Pantalla principal/portada de la app para Apple Watch: mandala, frase, navegación
struct HomeView: View {
    @State private var affirmation: String = AppConstants.affirmations.randomElement() ?? ""
    @State private var mandala: MandalaIdentity? = nil

    var body: some View {
        VStack(spacing: 14) {
            // Mandala visual del día
            if let mandala = mandala {
                Image(mandala.mandalaImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 76)
                    .shadow(color: mandala.uiColors.first ?? .purple, radius: 12)
                Text("Identidad del día:")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text(mandala.characterName)
                    .font(.headline)
                    .foregroundColor(mandala.uiColors.first ?? .blue)
            }
            // Frase/afirmación del día
            Text(affirmation)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.purple)
                .padding(.vertical, 6)

            Spacer()
            
            // Navegación a otras secciones
            VStack(spacing: 8) {
                NavigationLink("Registrar estado vital", destination: VitalInputView())
                NavigationLink("Sugerencia de Kriya", destination: VitalKriyaSuggestionView())
                NavigationLink("Diario", destination: DiaryListView())
            }
            .font(.callout)
            .padding(.bottom, 12)
        }
        .onAppear {
            // Cargar mandala del día usando tu manager
            mandala = MandalaManager().mandalaForToday()
            affirmation = AppConstants.affirmations.randomElement() ?? ""
        }
        .navigationTitle("Vitalidad Kundalini")
    }
}
