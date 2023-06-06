import Foundation
import ActivityKit

public struct TimerAttributes: ActivityAttributes {
    public typealias TimerState = ContentState
    
    public struct ContentState: Codable, Hashable {
        var plannedDuration: ClosedRange<Date>
    }
    var actionName: String
}
