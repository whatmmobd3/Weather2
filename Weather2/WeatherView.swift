import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Adelaide")
                .font(.largeTitle)
                .padding()
            Text("25ºC")
                .font(.system(size: 70))
                .bold()
            
//            Image(systemName: "cloud.sun")
//                .renderingMode(.original)
//                .padding()
                
            Text("Clear Sky")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
