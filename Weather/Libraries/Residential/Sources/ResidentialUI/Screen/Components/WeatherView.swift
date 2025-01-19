import SwiftUI

struct WeatherView: View {
    private let uiModel: WeatherUiModel
    
    public init(uiModel: WeatherUiModel) {
        self.uiModel = uiModel
    }

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            imageView
            textView
            detailView
        }
        Spacer()
    }
}

// MARK: - Layout

extension WeatherView {
    
    @ViewBuilder
    private var imageView: some View {
        if let url = uiModel.imageUrl {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
            } placeholder: { }
        }
    }
    
    private var textView: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: 10) {
                Text(uiModel.cityName)
                    .font(.system(size: 30, weight: .semibold))
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            Text(uiModel.temperature)
                .font(.system(size: 70, weight: .semibold))
        }
    }
    
    private var detailView: some View {
        HStack(alignment: .center) {
            detailItem(title: "Humidity", subtitle: uiModel.humidity)
                .padding(.leading, 16)
            Spacer()
            detailItem(title: "UV", subtitle: uiModel.uv)
            Spacer()
            detailItem(title: "Feels like", subtitle: uiModel.feelsLike)
                .padding(.trailing, 16)
        }
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .padding(.horizontal, 45)
        .padding(.vertical, 16)
    }
    
    private func detailItem(
        title: String, subtitle: String
    ) -> some View {
        VStack(alignment: .center, spacing: 2) {
            Text(title)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.gray)
            Text(subtitle)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.gray)
        }
        .padding(.vertical, 16)
    }
}
