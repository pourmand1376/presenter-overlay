import AppKit

enum Settings {
    private static let defaults = UserDefaults.standard

    private enum Key {
        static let isMirrored = "isMirrored"
        static let backgroundRemoval = "backgroundRemoval"
        static let shade = "shade"
        static let overlayShape = "overlayShape"
        static let cameraUniqueID = "cameraUniqueID"
        static let windowFrame = "windowFrame"
    }

    static var isMirrored: Bool {
        get { defaults.object(forKey: Key.isMirrored) as? Bool ?? true }
        set { defaults.set(newValue, forKey: Key.isMirrored) }
    }

    static var backgroundRemoval: Bool {
        get { defaults.bool(forKey: Key.backgroundRemoval) }
        set { defaults.set(newValue, forKey: Key.backgroundRemoval) }
    }

    static var shade: Bool {
        get { defaults.object(forKey: Key.shade) as? Bool ?? true }
        set { defaults.set(newValue, forKey: Key.shade) }
    }

    static var overlayShape: OverlayShape {
        get {
            (defaults.string(forKey: Key.overlayShape)).flatMap(OverlayShape.init(rawValue:)) ?? .circle
        }
        set { defaults.set(newValue.rawValue, forKey: Key.overlayShape) }
    }

    static var cameraUniqueID: String? {
        get { defaults.string(forKey: Key.cameraUniqueID) }
        set { defaults.set(newValue, forKey: Key.cameraUniqueID) }
    }

    static var windowFrame: NSRect? {
        get {
            guard let s = defaults.string(forKey: Key.windowFrame) else { return nil }
            let r = NSRectFromString(s)
            return r == .zero ? nil : r
        }
        set {
            if let r = newValue {
                defaults.set(NSStringFromRect(r), forKey: Key.windowFrame)
            } else {
                defaults.removeObject(forKey: Key.windowFrame)
            }
        }
    }
}
