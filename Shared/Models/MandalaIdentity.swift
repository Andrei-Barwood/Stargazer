import Foundation
import SwiftUI

/// Representa la identidad espiritual y visual del día (mandala + personaje + afirmación)
struct MandalaIdentity: Identifiable, Codable, Equatable {
    let id: UUID
    var characterName: String          // Nombre del personaje/referencia
    var colorSet: [String]             // Colores principales (hex o nombre)
    var mandalaImageName: String       // Imagen usable en Assets
    var affirmation: String            // Frase/afirmación del día

    init(
        characterName: String,
        colorSet: [String],
        mandalaImageName: String,
        affirmation: String
    ) {
        self.id = UUID()
        self.characterName = characterName
        self.colorSet = colorSet
        self.mandalaImageName = mandalaImageName
        self.affirmation = affirmation
    }

    // Devuelve SwiftUI Colors si necesitas para gradientes, usando hex
    var uiColors: [Color] {
        colorSet.compactMap { Color(hex: $0) }
    }
}

// Extension/ayuda: convierte hex (ej "#AABBCC") a SwiftUI Color
extension Color {
    init?(hex: String) {
        var hex = hex
        if hex.hasPrefix("#") { hex.removeFirst() }
        guard let intCode = Int(hex, radix: 16) else { return nil }
        let red = Double((intCode >> 16) & 0xFF) / 255.0
        let green = Double((intCode >> 8) & 0xFF) / 255.0
        let blue = Double(intCode & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
