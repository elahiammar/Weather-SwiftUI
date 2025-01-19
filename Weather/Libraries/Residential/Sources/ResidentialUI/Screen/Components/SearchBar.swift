import SwiftUI

public struct SearchBar: View {
    @Binding var text: String
    private let actionModel: UiActionModel
    
    public  init(
        text: Binding<String>,
        actionModel: UiActionModel
    ) {
        self._text = text
        self.actionModel = actionModel
    }
  
    public  var body: some View {
        HStack {
            textField
            textFieldIcon
        }
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .padding(.vertical, 32)
        .padding(.horizontal, 24)
    }
}

// MARK: - Layout

extension SearchBar {
    
    private var textField: some View {
        TextField("Search Location", text: $text)
            .keyboardType(.webSearch)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .onSubmit {
                actionModel.onSearchAction?()
            }
    }
    
    private var textFieldIcon: some View {
        Image(
            systemName: text == "" ? "magnifyingglass" : "xmark.circle"
        )
        .imageScale(.medium)
        .foregroundColor(Color(.systemGray))
        .padding(.horizontal, 20)
        .onTapGesture {
            withAnimation {
                text = ""
            }
        }
    }
}

public extension SearchBar {
    struct UiActionModel {
        let onSearchAction: (() -> Void)?
    }
}
