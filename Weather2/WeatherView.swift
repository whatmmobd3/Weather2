import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.cityName)
                .font(.largeTitle)
                .padding()
            Text("\(viewModel.temperature)ºC")
                .font(.system(size: 70))
                .bold()
            Text(viewModel.weatherIcon)
                .font(.largeTitle)
                .padding()
            
//            Image(systemName: "cloud.sun")
//                .renderingMode(.original)
//                .padding()
                
            Text(viewModel.weatherDescription)
        }.onAppear(perform: {
            viewModel.refresh()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
