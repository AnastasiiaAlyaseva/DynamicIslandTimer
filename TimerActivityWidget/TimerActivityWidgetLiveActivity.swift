import ActivityKit
import WidgetKit
import SwiftUI

struct TimerActivityWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var value: Int
    }
    var name: String
}

struct TimerActivityWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "timer")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        Text(context.attributes.actionName)
                        Text("Time Left: ")
                    }
                    
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ProgressView(timerInterval: context.state.plannedDuration)
                }
            } compactLeading: {
                
            } compactTrailing: {
                Image(systemName: "timer")
            } minimal: {
                
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

struct TimerActivityWidgetLiveActivity_Previews: PreviewProvider {
    static let attributes = TimerActivityWidgetAttributes(name: "Me")
    static let contentState = TimerActivityWidgetAttributes.ContentState(value: 3)
    
    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expanded")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
