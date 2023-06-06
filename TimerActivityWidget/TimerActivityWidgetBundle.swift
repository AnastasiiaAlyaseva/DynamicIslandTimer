import WidgetKit
import SwiftUI

@main
struct TimerActivityWidgetBundle: WidgetBundle {
    var body: some Widget {
        TimerActivityWidget()
        TimerActivityWidgetLiveActivity()
    }
}
