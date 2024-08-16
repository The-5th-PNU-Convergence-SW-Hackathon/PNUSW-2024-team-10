import SwiftUI

enum CourseStatusLabelType {
    case now, wish, done
    
    var text: String {
        switch self {
            case .now: return "Now"
            case .wish: return "Wish"
            case .done: return "Done"
        }
    }
    
    var color: Color {
        switch self {
            case .now: return .labelRed
            case .wish: return .labelBlue
            case .done: return .labelGray
        }
    }
}

enum PlaceThemeLabelType {
    case historic, nature, culture, shopping
    
    var text: String {
        switch self {
            case .historic: return "Historic"
            case .nature: return "Nature"
            case .culture: return "Culture"
            case .shopping: return "Shopping"
        }
    }
    
    var color: Color {
        switch self {
            case .historic: return .labelYellow
            case .nature: return .labelGreen
            case .culture: return .labelBlue
            case .shopping: return .labelRed
        }
    }
}

enum FoodLabelType {
    case vegan, blueribbon, halal, michelin, single
    
    var text: String {
        switch self {
            case .vegan: return "Vegan"
            case .blueribbon: return "Blue Ribbon Survey"
            case .halal: return "Halal"
            case .michelin: return "Michelin Guide"
            case .single: return "Single Seater"
        }
    }
    
    var color: Color {
        switch self {
            case .vegan: return .labelGreen
            case .blueribbon: return .labelBlue
            case .halal: return .labelYellow
            case .michelin: return .labelRed
            case .single: return .labelViolet
        }
    }
}

struct CourseStatusLabelView: View {
    private var type: CourseStatusLabelType
    
    init(_ type: CourseStatusLabelType) {
        self.type = type
    }
    
    var body: some View {
        HeronLabel(color: type.color) {
            Text(type.text)
        }
    }
}

struct PlaceThemeLabelView: View {
    private var type: PlaceThemeLabelType
    
    init(_ type: PlaceThemeLabelType) {
        self.type = type
    }
    
    var body: some View {
        HeronLabel(color: type.color) {
            Text(type.text)
        }
    }
}

struct FoodLabelView: View {
    private var type: FoodLabelType
    
    init(_ type: FoodLabelType) {
        self.type = type
    }
    
    var body: some View {
        HeronLabel(color: type.color) {
            Text(type.text)
        }
    }
}
