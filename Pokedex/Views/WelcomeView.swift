//
//  WelcomeView.swift
//  Pokedex
//
//  Created by Vu Trinh on 9/12/22.
//

import SwiftUI
// Welcome view before showing the pokedex
struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.green]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))

                VStack {
                    Spacer()
                    Text("Pokedex")
                        .font(.title).foregroundColor(.black)
                    Spacer()
                    NavigationLink {
                        ContentView().navigationBarBackButtonHidden(true)
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 90, height: 60, alignment: .center)
                                .foregroundColor(Color.mint)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            Text("Start")
                                .tint(.black)
                        }
                    }
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
