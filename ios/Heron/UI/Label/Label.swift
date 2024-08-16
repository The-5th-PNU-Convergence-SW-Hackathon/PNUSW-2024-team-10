import SwiftUI

struct HeronLabel<Content: View>: View {
    private var color: Color
    private var spacing: CGFloat
    private let content: Content
    
    init(color: Color = .labelGray, spacing: CGFloat = 2, @ViewBuilder content: () -> Content) {
        self.color = color
        self.spacing = spacing
        self.content = content()
    }
    
    var body: some View {
        HStack(spacing: spacing) {
            content
                .font(.caption.bold())
                .foregroundStyle(.white)
                .textCase(.uppercase)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    VStack {
        HeronLabel {
            Text("Done")
        }
        HeronLabel(color: .blue) {
            Text("In Progress")
        }
        HeronLabel(color: .green) {
            Image(systemName: "checkmark")
            Text("Completed")
        }
    }
    .padding()
}
