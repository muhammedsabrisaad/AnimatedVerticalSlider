//
//  Home.swift
//  AnimatedVerticalSlider
//
//  Created by Muhammad Sabri Saad on 06/12/2021.
//

import SwiftUI

struct Home: View {
    @State var maxHeight:CGFloat = UIScreen.main.bounds.height / 2.5
    
    @State var sliderProgress:CGFloat = 0
    @State var sliderHeight:CGFloat = 0
    @State var lastDragValue:CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .bottom, content: {
                    Rectangle()
                        .fill(Color("SliderColor").opacity(0.15))
                    Rectangle()
                        .fill(Color("SliderColor2"))
                        .frame(height: sliderHeight)
                    
                })
                    .frame(width: 100, height: maxHeight)
                    .cornerRadius(35)
                    .overlay(
                        Text("\(Int(sliderProgress * 100)) %")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.vertical,10)
                            .padding(.horizontal,16)
                            .background(Color.white)
                            .cornerRadius(12)
                            .padding(.vertical,20)
                            .offset(y:sliderHeight < maxHeight - 90 ? -sliderHeight : -maxHeight + 90)
                        
                        ,alignment: .bottom
                        
                    )
                    .gesture(DragGesture(minimumDistance: 0)
                                .onChanged({ value in
                        let translation = value.translation
                        sliderHeight = -translation.height + lastDragValue
                        
                        sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                        
                        sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                        
                        let progress = sliderHeight / maxHeight
                        sliderProgress = progress <= 1.0 ? progress : 1
                        
                    })
                                .onEnded({ value in
                        
                        sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                        
                        sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                        
                        lastDragValue = sliderHeight
                    }))
                
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BG").opacity(0.5)).ignoresSafeArea()
            .preferredColorScheme(.dark)
            .navigationTitle("Vertical Slider")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
