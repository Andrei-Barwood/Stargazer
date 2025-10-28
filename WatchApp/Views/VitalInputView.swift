import SwiftUI

/// Registro manual/automático de signos vitales y estado emocional en Apple Watch
struct VitalInputView: View {
    @State private var heartRate: Double = 72
    @State private var hrv: Double = 48
    @State private var breathingRate: Double = 14
    @State private var temperature: Double = 36.5
    @State private var oxygenLevel: Double = 98.0
    @State private var phLevel: Double = 7.36
    @State private var mood: String = "normal"
    @State private var showConfirmation: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Signos vitales")) {
                HStack {
                    Text("Pulso")
                    Spacer()
                    TextField("", value: $heartRate, format: .number)
                        .keyboardType(.decimalPad)
                        .frame(width: 54)
                    Text("bpm")
                }
                HStack {
                    Text("HRV")
                    Spacer()
                    TextField("", value: $hrv, format: .number)
                        .keyboardType(.decimalPad)
                        .frame(width: 54)
                    Text("ms")
                }
                HStack {
                    Text("Respiración")
                    Spacer()
                    TextField("", value: $breathingRate, format: .number)
                        .keyboardType(.decimalPad)
                        .frame(width: 54)
                    Text("/min")
                }
                HStack {
                    Text("Temperatura")
                    Spacer()
                    TextField("", value: $temperature, format: .number)
                        .keyboardType(.decimalPad)
                        .frame(width: 54)
                    Text("°C")
                }
                HStack {
                    Text("Oxígeno")
                    Spacer()
                    TextField("", value: $oxygenLevel, format: .number)
                        .keyboardType(.decimalPad)
                        .frame(width: 54)
                    Text("%")
                }
                HStack {
                    Text("pH")
                    Spacer()
                    Slider(value: $phLevel, in: 6.5...8.0, step: 0.01)
                    Text(String(format: "%.2f", phLevel))
                        .frame(width: 50)
                }
            }
            Section(header: Text("Estado emocional")) {
                Picker("Ánimo", selection: $mood) {
                    Text("feliz").tag("feliz")
                    Text("normal").tag("normal")
                    Text("triste").tag("triste")
                    Text("ansioso").tag("ansioso")
                    Text("sereno").tag("sereno")
                }
                .pickerStyle(.segmented)
            }
            Button("Registrar signos") {
                // Guardar en modelo/signos del usuario (se puede usar DiaryStore o Profile)
                showConfirmation = true
            }
            .buttonStyle(.borderedProminent)
        }
        .alert("Signos vitales registrados", isPresented: $showConfirmation) {
            Button("OK", role: .cancel) { }
        }
        .navigationTitle("Registro Vital")
    }
}
