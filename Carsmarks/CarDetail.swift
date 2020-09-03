/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the details for a landmark.
*/

import SwiftUI

struct CarDetail: View {
    @EnvironmentObject var userData: UserData
    var landmark: Car
    
    var landmarkIndex: Int {
        userData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    //@Environment(\.editMode) var mode
    @State var showingProfile = false
    var profileButton: some View {
        Button(action: {
            self.showingProfile.toggle()
            print("true", self.showingProfile.toggle())
        }) {
            Image(systemName: "square.and.pencil")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }.sheet(isPresented: $showingProfile) {
            ProfileHost().environmentObject(self.userData)
        }
    }
    
    @Environment(\.editMode) var mode
    @State var draftProfile = Profile.default
    
    var body: some View {
        
        VStack {
            
            MapView(coordinate: landmark.locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)
            
            CircleImage(image: landmark.image)
                .offset(x: 0, y: -130)
                .padding(.bottom, -130)
            
            
            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    
                    Button(action: {
                        self.userData.landmarks[self.landmarkIndex]
                            .isFavorite.toggle()
                    }) {
                        if self.userData.landmarks[self.landmarkIndex]
                            .isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                
                HStack(alignment: .top) {
                    Text(landmark.park)
                        .font(.subheadline)
                    Spacer()
                    Text(landmark.state)
                        .font(.subheadline)
                }
            }
            .padding()
            
            Spacer()
            if self.mode?.wrappedValue == .inactive {
                ProfileSummary(profile: userData.profile)
            } else {
                Text("Profile Editor")
            }
        }
        //.navigationBarItems(trailing: profileButton)
        .navigationBarTitle("Detail")
        .navigationBarItems(trailing:
            HStack {
                Button("About") {
                    print("About tapped!")
                }
                EditButton()
            }
            
        )
        
            
        
    }
}

struct CarDetail_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return CarDetail(landmark: userData.landmarks[0])
            .environmentObject(userData)
    }
}
