import Foundation

/// Gestor para manejar la rotación diaria de mandalas/identidades y frases de afirmación
class MandalaManager {
    private var mandalas: [MandalaIdentity] = []

    /// Inicialización opcional con lista previa (configuración, asset, json, etc.)
    init(mandalas: [MandalaIdentity] = []) {
        self.mandalas = mandalas
    }

    /// Genera el mandala del día usando la fecha (sin repetición semanal)
    func mandalaForToday() -> MandalaIdentity? {
        let todayOrdinal = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
        guard !mandalas.isEmpty else { return nil }
        let index = todayOrdinal % mandalas.count
        return mandalas[index]
    }

    /// Permite agregar una nueva identidad (para expansión, edición)
    func addMandala(_ mandala: MandalaIdentity) {
        mandalas.append(mandala)
    }

    /// Actualiza el set de frases/identidades según configuración externa
    func updateMandalaSet(_ newSet: [MandalaIdentity]) {
        mandalas = newSet
    }

    /// Recupera una identidad específica por nombre/referencia
    func mandala(named name: String) -> MandalaIdentity? {
        return mandalas.first { $0.characterName == name }
    }
}
