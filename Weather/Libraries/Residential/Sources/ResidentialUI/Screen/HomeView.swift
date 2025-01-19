import SwiftUI

public struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel
    @State private var showAlert: Bool = false
    @State private var searchText: String = ""
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(spacing: .zero) {
            SearchBar(
                text: $searchText,
                actionModel: .init(
                    onSearchAction: {
                        Task {
                            await viewModel.onSearchWeather(searchText)
                        }
                    }
                )
            )
            mainView
            Spacer()
        }
        .onAppear {
            Task {
                await viewModel.onAppear()
            }
        }
        .onChange(of: viewModel.errorMessage) { error in
            guard error != nil else { return }
            showAlert = true
        }
        .alert(viewModel.errorMessage ?? "", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                viewModel.onAlertDismissed()
            }
        }
    }
}

// MARK: - Layout

extension HomeView {
    
    @ViewBuilder
    private var mainView: some View {
        if let weatherDetails = viewModel.weatherDetails {
            switch weatherDetails {
            case .emptyState:
                emptyStateView
            case .noDataAvailable:
                EmptyView()
            case let .data(domainModel):
                let uiModel = WeatherUiModel(weather: domainModel)
                if !viewModel.weatherSelected {
                    SearchResultView(
                        uiModel: uiModel,
                        actionModel: .init(
                            onWeatherSelected: {
                                withAnimation {
                                    searchText = ""
                                    viewModel.onWeatherSelected(location: uiModel.cityName)
                                }
                            }
                        )
                    )
                } else {
                    WeatherView(uiModel: uiModel)
                }
            }
        }
    }
    
    @ViewBuilder
    private var emptyStateView: some View {
        Spacer()
        VStack(alignment: .center, spacing: 12) {
            Text("No City Selected")
                .font(.system(size: 30, weight: .semibold))
            Text("Please Search For A City")
                .font(.system(size: 14, weight: .semibold))
        }
    }
}
