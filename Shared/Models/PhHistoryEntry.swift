import Foundation

/// Registro individual de pH sanguíneo con fecha y valor
struct PhHistoryEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var date: Date
    var value: Double   // Valor pH sanguíneo

    init(date: Date = Date(), value: Double) {
        self.id = UUID()
        self.date = date
        self.value = value
    }
}
