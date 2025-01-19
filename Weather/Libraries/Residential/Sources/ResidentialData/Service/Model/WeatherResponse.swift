public struct WeatherResponse: Decodable {
    public let location: Location
    public let current: Temperature
    
    public init(location: Location, current: Temperature) {
        self.location = location
        self.current = current
    }

    public struct Location: Decodable {
        public let name: String
        
        public init(name: String) {
            self.name = name
        }
    }
    
    public struct Temperature: Decodable {
        public let temp_c: Float
        public let feelslike_c: Float
        public let humidity: Int
        public let uv: Float
        public let condition: TemperatureCondition
        
        public init(temp_c: Float, feelslike_c: Float, humidity: Int, uv: Float, condition: TemperatureCondition) {
            self.temp_c = temp_c
            self.feelslike_c = feelslike_c
            self.humidity = humidity
            self.uv = uv
            self.condition = condition
        }
    }

    public struct TemperatureCondition: Decodable {
        public let icon: String
        
        public init(icon: String) {
            self.icon = icon
        }
    }
}
