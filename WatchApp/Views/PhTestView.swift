import SwiftUI

/// Registro y sugerencia diaria de pH en Apple Watch
struct PhTestView: View {
    @State private var phValue: Double = 7.36
    @State private var suggestion: String = ""
    @State private var showConfirmation: Bool = false

    func updateSuggestion() {
        if phValue < 7.35 {
            suggestion = "Tu sangre está ligeramente ácida. Consume más vegetales verdes, jugos frescos y mantén la hidratación. Practica respiraciones profundas y balance."
        } else if phValue > 7.45 {
            suggestion = "Tendencia alcalina. Mantén dieta balanceada, frutas frescas y observa tu bienestar general."
        } else {
            suggestion = "¡Excelente! Tu pH sanguíneo está óptimo. Continúa tu dieta saludable y práctica de yoga."
        }
    }

    var body: some View {
        VStack(spacing: 14) {
            Text("Test de pH diario")
                .font(.headline)
            HStack {
                Text("pH sanguíneo:")
                Slider(value: $phValue, in: 6.5...8.0, step: 0.01)
                    .onChange(of: phValue) { _ in updateSuggestion() }
                Text(String(format: "%.2f", phValue))
                    .frame(width: 54)
            }
            .padding(.vertical)
            Button("Registrar pH") {
                updateSuggestion()
                showConfirmation = true
                // Guardar en historial del usuario (puedes usar PhStore)
            }
            .buttonStyle(.borderedProminent)
            Divider()
            Text("Sugerencia para hoy:")
                .font(.caption2)
                .foregroundColor(.secondary)
            Text(suggestion)
                .font(.body)
                .multilineTextAlignment(.center)
        }
        .onAppear { updateSuggestion() }
        .alert("Valor de pH registrado", isPresented: $showConfirmation) {
            Button("OK", role: .cancel) { }
        }
        .padding()
        .navigationTitle("Test de pH")
    }
}
