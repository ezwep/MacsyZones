//
// MacsyZones Dev — Pro lock disabled, always unlocked.
//

import Foundation

class VerifyResult {
    var isValid: Bool = false
    var owner: String? = nil

    init(isValid: Bool = false, owner: String? = nil) {
        self.isValid = isValid
        self.owner = owner
    }
}

class ProLock: ObservableObject {
    @Published var isPro: Bool = true
    @Published var owner: String? = "Dev"

    init() {}
    func load() {}
    func save() {}
    func setLicenseKey(_ key: String) -> Bool { return true }
}
