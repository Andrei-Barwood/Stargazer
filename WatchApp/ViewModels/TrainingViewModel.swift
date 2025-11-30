import Foundation
import Combine

/// ViewModel mejorado para gestionar el flujo de entrenamiento guiado
class TrainingViewModel: ObservableObject {
    @Published var currentKriya: Kriya?
    @Published var currentStepIndex: Int = 0
    @Published var isTraining: Bool = false
    @Published var secondsElapsed: Int = 0
    @Published var isFinished: Bool = false
    @Published var progress: Double = 0.0
    @Published var beforeVitals: VitalSigns?
    @Published var afterVitals: VitalSigns?
    
    private var timer: Timer?
    private let diaryStore: DiaryStore
    private let phStore: PhStore
    
    init(diaryStore: DiaryStore, phStore: PhStore) {
        self.diaryStore = diaryStore
        self.phStore = phStore
    }
    
    /// Inicia el entrenamiento guiado
    func startTraining(with kriya: Kriya, beforeVitals: VitalSigns) {
        currentKriya = kriya
        self.beforeVitals = beforeVitals
        currentStepIndex = 0
        secondsElapsed = 0
        isFinished = false
        isTraining = true
        updateProgress()
        startTimer()
    }
    
    /// Detiene el entrenamiento
    func stopTraining() {
        isTraining = false
        timer?.invalidate()
        timer = nil
    }
    
    /// Avanza al siguiente paso
    func nextStep() {
        guard let kriya = currentKriya else { return }
        if currentStepIndex < kriya.steps.count - 1 {
            currentStepIndex += 1
            updateProgress()
        } else {
            completeTraining()
        }
    }
    
    /// Retrocede al paso anterior
    func previousStep() {
        if currentStepIndex > 0 {
            currentStepIndex -= 1
            updateProgress()
        }
    }
    
    /// Marca el entrenamiento como completo
    func completeTraining() {
        isFinished = true
        stopTraining()
    }
    
    /// Genera el coaching y registra en diario
    func generateCoachingAndRegister(afterVitals: VitalSigns) {
        guard let kriya = currentKriya, let before = beforeVitals else { return }
        self.afterVitals = afterVitals
        
        let coachingMessage = CoachingGenerator.generate(
            kriya: kriya,
            beforeVitals: before,
            afterVitals: afterVitals
        )
        
        let entry = DiaryEntry(
            timestamp: Date(),
            kriyaName: kriya.name,
            notes: "Práctica completada en \(secondsElapsed / 60) minutos",
            mood: afterVitals.mood,
            coachingMessage: coachingMessage,
            beforeVitals: before,
            afterVitals: afterVitals,
            isFavorite: false
        )
        
        diaryStore.addEntry(entry)
        phStore.add(value: afterVitals.phLevel ?? 7.36, date: Date())
    }
    
    /// Actualiza el progreso
    private func updateProgress() {
        guard let kriya = currentKriya else { return }
        progress = Double(currentStepIndex + 1) / Double(kriya.steps.count)
    }
    
    /// Inicia cronómetro
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.secondsElapsed += 1
        }
    }
}
