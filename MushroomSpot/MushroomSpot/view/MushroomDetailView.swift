//
//  MushroomDetailView.swift
//  MushroomSpot
//
//  Created by prem on 20/4/25.
//
import SwiftUI

struct MushroomDetailView: View {
    let mushroom: Mushroom
    
    var body: some View {
        VStack(spacing: 20) {
            // Decode and display the image
            if let base64 = mushroom.profilePicture.components(separatedBy: ",").last,
               let imageData = Data(base64Encoded: base64),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 200)
            }
            
            Text(mushroom.name)
                .font(.title)
                .bold()
            
            Text(mushroom.latinName)
                .font(.headline)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle(mushroom.name)
    }
}
