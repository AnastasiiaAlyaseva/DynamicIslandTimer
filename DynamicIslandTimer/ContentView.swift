import SwiftUI
import ActivityKit

struct ContentView: View {
    
    @State private var currentActivity: Activity<TimerAttributes>?
    @State private var currentActivityContent: ActivityContent<Activity<TimerAttributes>.ContentState>?
    @State private var selectedDuration = 1
    @State private var isTimerRunning = false
    
    var body: some View {
        VStack {
            Picker("Select Duration", selection: $selectedDuration) {
                ForEach(1...60, id: \.self) { minute in
                    Text("\(minute) min" )
                }
            }
                .labelsHidden()
                .pickerStyle(.menu)
            
            Image(systemName: "clock.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            HStack {
                Button(action: startActivity) {
                    Text("Start Timer")
                        .font(.title2)
                }
                .disabled(isTimerRunning)
                
                Button(action: stopActivity) {
                    Text("Stop Timer")
                        .font(.title2)
                }
                .disabled(!isTimerRunning)
            }
        }
        .padding()
    }
    
    func startActivity() {
        let startDate = Date()
        guard let endDate = Calendar.current.date(byAdding: .minute, value: selectedDuration, to: startDate) else { return }
        let interval = startDate...endDate
        
        let attributes = TimerAttributes (actionName: "Delivery")
        let state = TimerAttributes.TimerState(plannedDuration: interval)
        
        do {
            let activityContent = ActivityContent(state: state, staleDate: nil)
            currentActivityContent = activityContent
            currentActivity = try Activity<TimerAttributes>.request(
                attributes: attributes,
                content: activityContent
            )
            isTimerRunning = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func stopActivity() {
        Task {
            await currentActivity?.end(currentActivityContent,  dismissalPolicy: .immediate)
            currentActivity = nil
            isTimerRunning = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
