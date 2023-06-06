import SwiftUI
import ActivityKit

struct ContentView: View {
    
    @State private var currentActivity: Activity<TimerAttributes>?
    
    var body: some View {
        VStack {
            Image(systemName: "clock.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            Button( action: startActivity) {
                Text("Start Timer")
                    .foregroundColor(.black)
                    .font(.title2)
            }
        }
        .padding()
    }
    
    func startActivity() {
        let startDate = Date.now
        guard let endDate = Calendar.current.date(byAdding: .minute, value: 1, to: startDate) else { return }
        let interval = startDate...endDate
        
        let attributes = TimerAttributes (actionName: "Delivery")
        let state = TimerAttributes.TimerState(plannedDuration: interval)
        
        do {
            currentActivity = try Activity<TimerAttributes>.request(attributes: attributes, content: ActivityContent(state: state, staleDate: nil))
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
