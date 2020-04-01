import Foundation

class MockScanner: Scanner {
    private weak var agent: BeaconIdAgent?
    private var mode: ScannerMode = .Disabled

    init(agent: BeaconIdAgent) {
        self.agent = agent
        let timer = Timer.init(
            timeInterval: TimeInterval(DebugMenu.assign(DebugMenu.mockBluetoothScannerInterval)),
            repeats: true) { [weak self] _ in
                self?.agent?.synchronizedBeaconId(beaconId: BeaconId.random(), rssi: Int.random(in: (-40)..<(-140)))
        }
        RunLoop.current.add(timer, forMode: .common)
    }

    func setMode(_ mode: ScannerMode) {
        self.mode = mode
    }

    func getMode() -> ScannerMode {
        return self.mode
    }

    func isScanning() -> Bool {
        switch self.mode {
        case .Disabled:
            return false
        default:
            return true
        }
    }
}
