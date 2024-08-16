import SwiftUI

enum CoursesLabelType {
    case all, wish, done
    
    var text: String {
        switch self {
            case .all: return "All"
            case .wish: return "Wish"
            case .done: return "Done"
        }
    }
    
    var color: Color {
        switch self {
            case .all: return .labelRed
            case .wish: return .labelBlue
            case .done: return .labelGray
        }
    }
}

struct CoursesLabelView: View {
    private var type: CoursesLabelType
    
    init(_ type: CoursesLabelType) {
        self.type = type
    }
    
    var body: some View {
        HeronLabel(color: type.color) {
            Text(type.text)
        }
    }
}
