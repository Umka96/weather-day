//
//  URLShortenManager.swift
//  Wather day
//
//  Created by Uma Bugrayeva on 10.02.2023.
//

import Foundation

// Model
//struct URLShort : Codable {
//    var data: URLData
//    var code: Int
//    var errors: [String?]
//}
//
//struct URLData : Codable {
//    var url: String
//    var domain, alias: String
//    var tinyURL: String?
//}
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main: Codable {
    let temp: Double
}
struct Weather: Codable {
    let description: String
    let id: Int
}

@MainActor class URLShortenManager : ObservableObject {
    //    private let API_KEY = "2W2AHuEG1XPH17F7qIInwsVTfV4TQ9Ou5DQiq3e7xi6ANkqQpbI6OXB1QoJe"
    @Published var imageWeath = ""
    @Published var citi = ""
    @Published var tempi = ""
    @Published var image2Weath = ""
    @Published var inputURL = "https://api.openweathermap.org/data/2.5/weather?appid=6cdddd7b5a0b43e146ff23e57a7490e3&units=metric&q=Kyiv"
    // це додати але не тут думай )
    
    
    func getData() {
        guard let url = URL(string: "\(inputURL)") else {
            print("Invalid URL")
            return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Could not retrieve data...")
                DispatchQueue.main.async {
                    self.tempi = "Could not retrieve data..."
                    self.citi = "Could not retrieve data..."
                    self.image2Weath = ""
                }
                return }
            
            // Step 4: Decode the data from the URL
            
            do {
                let shortenedURL = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    print(shortenedURL)
                    var conditionName: String {
                        switch shortenedURL.weather[0].id {
                        case 200...232:
                            return "cloud.bolt"
                        case 300...321:
                            return "cloud.drizzle"
                        case 500...531:
                            return "cloud.rain"
                        case 600...622:
                            return "cloud.snow"
                        case 701...781:
                            return "cloud.fog"
                        case 800:
                            return "sun.max"
                        case 801...804:
                            return "cloud.bolt"
                        default:
                            return "cloud"
                        }
                    }
                    self.tempi = "\(String(format: "%.0f", shortenedURL.main.temp)) C"
                    self.imageWeath = "\(shortenedURL.weather[0].description)"
                    self.image2Weath = "\(conditionName)"
                    self.citi = "Kyiv"
                }
            } catch {
                DispatchQueue.main.async {
                    self.tempi = "error"
                    self.imageWeath = "error"
                }
                print("\(error)")
            }
        }.resume()
    }
}
