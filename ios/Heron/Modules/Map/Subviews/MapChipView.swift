import SwiftUI

enum ChipType {
    case iconOnly
    case textOnly
    case both
}

struct MapChip: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    let text: String
    let icon: Image
    var type: ChipType? = .both
    var isEnabled: Bool? = false
    var onChange: ((Bool) -> Void)? = nil

    
    var body: some View {
        ZStack {
            Button(action: {
                onChange?(!isEnabled!)
            }) {
                HStack(alignment: .center) {
                    if type == .iconOnly || type == .both {
                        icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(isEnabled! ? .white : Color(.label).opacity(0.6))
                    }
                    if type == .textOnly || type == .both {
                        Text(text)
                            .font(.system(size: 14))
                            .foregroundStyle(isEnabled! ? .white : Color(.label).opacity(0.6))
                            .padding(.leading, type == .both ? 2 : 0)
                    }
                }
                .padding(.horizontal, type == .iconOnly ? 0 : 14)
                .frame(
                    width: type == .iconOnly ? 38 : nil,
                    height: 38
                )
            }
            .background(
                isEnabled!
                ? Color.accentColor
                : colorScheme == .dark
                ? Color(.label).opacity(0.05)
                : Color(.systemBackground).opacity(0.5)
            )
            .clipShape(.rect(cornerRadius: 10))
        }
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.separator).opacity(0.5), lineWidth: 0.33)
        )
        .shadow(
            color: .black.opacity(0.03),
            radius: 5,
            x: 0, y: 10
        )
    }
}

#Preview {
    VStack {
        MapChip(text: "Example Chip", icon: Image(systemName: "star.fill"), type: .both, isEnabled: true)
        MapChip(text: "Icon Only", icon: Image(systemName: "star.fill"), type: .iconOnly, isEnabled: false)
        MapChip(text: "Text Only", icon: Image(systemName: "star.fill"), type: .textOnly, isEnabled: true)
    }
    .padding()
}
