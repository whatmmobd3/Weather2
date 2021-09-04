import Foundation
import CoreLocation

public final class WeatherService: NSObject{
    private let locationManager = CLLocationManager()
    private let API_KEY = "15d720c336dd24d9479f904414a55b80"
    private var completionHandler: ((Weather) -> Void)?
    
    public override init(){
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)){
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
//    https://api.openweathermap.org/data/2.5/weather?lat=33.44&lon=-88.25&appid=15d720c336dd24d9479f904414a55b80
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D){
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric"
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url){data, reponse, error in
            guard error == nil, let data = data else { return }
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data){
                print(response)
                self.completionHandler?(Weather(response: response))
            }
            
        }.resume()
    }
}

extension WeatherService: CLLocationManagerDelegate{
    public func locationManager(
        _ manager:CLLocationManager,
        didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else {
            return
        }
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(
        _ manger: CLLocationManager,
        didFailWithError error: Error
    ){
        print("Something went wrong: \(error.localizedDescription)")
    }
}

struct APIResponse: Decodable {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}

struct APIMain: Decodable{
    let temp: Double
}

struct APIWeather: Decodable{
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
