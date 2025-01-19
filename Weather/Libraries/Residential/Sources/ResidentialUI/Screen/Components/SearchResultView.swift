
import SwiftUI

public struct SearchResultView: View {
    private let uiModel: WeatherUiModel
    private let actionModel: UiActionModel
    
    public init(
        uiModel: WeatherUiModel,
        actionModel: UiActionModel
    ) {
        self.uiModel = uiModel
        self.actionModel = actionModel
    }
  
    public var body: some View {
        HStack(alignment: .center) {
            textView
            Spacer()
            imageView
        }
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .padding(.horizontal, 20)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                actionModel.onLocationSelected?()
            }
        }
        Spacer()
    }
}

// MARK: - Layout

extension SearchResultView {
    
    private var textView: some View {
        VStack(alignment: .leading) {
            Text(uiModel.cityName)
                .font(.system(size: 20, weight: .semibold))
            Text(uiModel.temperature)
                .font(.system(size: 60, weight: .semibold))
        }
        .padding(.leading, 30)
        .padding(.vertical, 16)
    }
    
    @ViewBuilder
    private var imageView: some View {
        if let url = uiModel.imageUrl {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .padding(.trailing, 30)
                    .frame(width: 85, height: 85)
            } placeholder: { }
        }
    }
}

public extension SearchResultView {
    struct UiActionModel {
        let onLocationSelected: (() -> Void)?
    }
}
