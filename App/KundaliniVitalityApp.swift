import SwiftUI
import CloudKit

@main
struct KundaliniVitalityApp: App {
    @StateObject private var diaryStore = DiaryStore()
    @StateObject private var phStore = PhStore()
    @StateObject private var mandalaManager = MandalaManager(mandalas: defaultMandalas())
    @StateObject private var kriyaCatalogLoader = KriyaCatalogLoader()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                // Fondo con gradiente sutil
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.95, green: 0.93, blue: 0.95),
                        Color(red: 0.99, green: 0.97, blue: 0.98)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                #if os(watchOS)
                HomeView()
                    .environmentObject(diaryStore)
                    .environmentObject(phStore)
                    .environmentObject(mandalaManager)
                    .environmentObject(kriyaCatalogLoader)
                #else
                MainDashboardView()
                    .environmentObject(diaryStore)
                    .environmentObject(phStore)
                    .environmentObject(mandalaManager)
                    .environmentObject(kriyaCatalogLoader)
                #endif
            }
        }
    }
    
    /// Mandalas predeterminados para la app (rotación diaria)
    private static func defaultMandalas() -> [MandalaIdentity] {
        [
            MandalaIdentity(
                characterName: "Luminescence",
                colorSet: ["#A2D6F9", "#FFE5A5"],
                mandalaImageName: "mandala_luminescence",
                affirmation: "En cada instante, eres digno@ de confianza y existencia."
            ),
            MandalaIdentity(
                characterName: "Serenity",
                colorSet: ["#FCD6E6", "#F3B7D1"],
                mandalaImageName: "mandala_serenity",
                affirmation: "La paz se encuentra en la aceptación de la realidad."
            ),
            MandalaIdentity(
                characterName: "Essence",
                colorSet: ["#B0EACD", "#C4F1BE"],
                mandalaImageName: "mandala_essence",
                affirmation: "Tus ideas viajan como nubes, proyectando tu esencia."
            ),
            MandalaIdentity(
                characterName: "Infinity",
                colorSet: ["#E5C7FF", "#BEE4F2"],
                mandalaImageName: "mandala_infinity",
                affirmation: "No necesitas espacio ni tiempo para ser libre."
            ),
            MandalaIdentity(
                characterName: "Vitality",
                colorSet: ["#FFE5A5", "#FFB366"],
                mandalaImageName: "mandala_vitality",
                affirmation: "La vitalidad es tu naturaleza profunda."
            ),
            MandalaIdentity(
                characterName: "Trust",
                colorSet: ["#C4F1BE", "#A2D6F9"],
                mandalaImageName: "mandala_trust",
                affirmation: "La verdadera libertad nace de la confianza."
            ),
            MandalaIdentity(
                characterName: "Celestial",
                colorSet: ["#F3B7D1", "#E5C7FF"],
                mandalaImageName: "mandala_celestial",
                affirmation: "Eres infinito bajo cualquier cielo."
            ),
            MandalaIdentity(
                characterName: "Consciousness",
                colorSet: ["#BEE4F2", "#A2D6F9"],
                mandalaImageName: "mandala_consciousness",
                affirmation: "No hay límite en la conciencia creativa."
            )
        ]
    }
}
