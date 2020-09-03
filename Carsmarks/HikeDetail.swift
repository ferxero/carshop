/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the details for a hike.
*/

import SwiftUI

struct HikeDetail: View {
    let hike: Location
    @State var dataToShow = \Location.Observation.elevation
    
    var buttons = [
        ("Elevation", \Location.Observation.elevation),
        ("Heart Rate", \Location.Observation.heartRate),
        ("Pace", \Location.Observation.pace),
    ]
    
    var body: some View {
        return VStack {
            HikeGraph(hike: hike, path: dataToShow)
                .frame(height: 200)
            
            HStack(spacing: 25) {
                ForEach(buttons, id: \.0) { value in
                    Button(action: {
                        self.dataToShow = value.1
                    }) {
                        Text(value.0)
                            .font(.system(size: 15))
                            .foregroundColor(value.1 == self.dataToShow
                                ? Color.gray
                                : Color.accentColor)
                            .animation(nil)
                    }
                }
            }
        }
    }
}

struct HikeDetail_Previews: PreviewProvider {
    static var previews: some View {
        HikeDetail(hike: hikeData[0])
    }
}
