import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color("lightblue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Text(viewModel.cityName)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                
                Text("\(viewModel.temperature)ºC")
                    .font(.system(size: 70))
                    .foregroundColor(.white)
                    .bold()
                
                Image(systemName: viewModel.weatherIcon)
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
                    
                Text(viewModel.weatherDescription)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
            }.onAppear(perform: {
                viewModel.refresh()
        })
            .padding(.bottom,300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
