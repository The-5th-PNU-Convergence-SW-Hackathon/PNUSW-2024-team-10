import SwiftUI

struct CourseListItem: View {
    var title: String
    var imageURL: URL?
    var zone: String
    var duration: String
    var label: CourseStatusLabelType?
    var landmark: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    AsyncImage(url: imageURL) { image in
                        image.image?.resizable()
                    }
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .clipShape(.rect(cornerRadius: 6))
                        
                    
                    VStack(alignment: .leading, spacing: 7) {
                        Text("\(title)")
                            .font(.system(size: 18, weight: .semibold))
                            .lineLimit(2)
                        
                        HStack {
                            Text("\(zone), \(duration)")
                                .font(.system(size: 14)).foregroundStyle(.secondary)
                        }
                        
                        if (label != nil) {
                            CourseStatusLabelView(label!)
                        }
                    }
                    .frame(minHeight: 100, alignment: .center)
                        
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(alignment: .firstTextBaseline) {
                    Text("Land Mark".uppercased()).font(.system(size: 13, weight: .semibold))
                    Text("\(landmark)").font(.system(size: 13, weight: .medium)).foregroundStyle(Color.accentColor)
                }
            }
            .padding(10)
            
            CourseDetailsLink()
        }
        
    }
}

#Preview {
    MainTabView(selection: 1)
}
