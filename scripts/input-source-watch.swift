import Carbon
import Foundation

func currentInputSourceID() -> String {
    let source = TISCopyCurrentKeyboardInputSource().takeRetainedValue()
    guard let pointer = TISGetInputSourceProperty(source, kTISPropertyInputSourceID) else {
        return "unknown"
    }
    return Unmanaged<CFString>.fromOpaque(pointer).takeUnretainedValue() as String
}

func emitCurrentInputSource() {
    let line = currentInputSourceID() + "\n"
    FileHandle.standardOutput.write(line.data(using: .utf8)!)
}

let callback: CFNotificationCallback = { _, _, _, _, _ in
    emitCurrentInputSource()
}

CFNotificationCenterAddObserver(
    CFNotificationCenterGetDistributedCenter(),
    nil,
    callback,
    kTISNotifySelectedKeyboardInputSourceChanged,
    nil,
    .deliverImmediately
)

emitCurrentInputSource()
CFRunLoopRun()
