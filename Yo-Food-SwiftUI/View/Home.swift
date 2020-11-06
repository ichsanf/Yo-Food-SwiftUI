//
//  Home.swift
//  Yo-Food-SwiftUI
//
//  Created by Achmad Ichsan Fauzi on 06/11/20.
//

import SwiftUI

struct Home: View {
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 15) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.pink)
                })
                
                Text("Deliver to")
                    .foregroundColor(.black)
                
                Text("Apple")
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundColor(.pink)
                
                Spacer()
            }
            .padding([.horizontal, .top])
            
            Divider()
            
            HStack(spacing: 15) {
                TextField("Search", text: $HomeModel.search)
                
                if HomeModel.search != "" {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(.gray)
                    })
                    .animation(.easeIn)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Divider()
            
            Spacer()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
