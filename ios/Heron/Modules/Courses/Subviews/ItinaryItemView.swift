import SwiftUI

struct ItinaryItem {
    var title: String
    var description: String
    var time: String
    var mission: String?
}

struct ItinaryItemView: View {
    private var title: String
    private var description: String
    private var time: String
    private var mission: String?

    init(_ itinary: ItinaryItem) {
        self.title = itinary.title
        self.description = itinary.description
        self.time = itinary.time
        self.mission = itinary.mission
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(title)")
                .font(.title3).bold().foregroundStyle(Color.accentColor)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
            
            HStack(alignment: .top) {
                Image(systemName: "camera.fill")
                    .foregroundStyle(Color(.systemGray))
                    .frame(width: 100, height: 80)
                    .background(Color(.separator).opacity(0.3))
                    .clipShape(.rect(cornerRadius: 6))
                VStack(alignment: .leading, spacing: 12) {
                    Text("\(description)")
                        .font(.system(size: 14))
                    
                    Text("Suggest Time: \(time)")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(.secondaryLabel))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
            
            if (mission != nil) {
                HStack(alignment: .firstTextBaseline) {
                    Text("Mission")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color.accentColor)
                    Text("\(mission!)")
                        .font(.system(size: 13))
                    
                }
            }
        }
        .padding(12)
    }
}
