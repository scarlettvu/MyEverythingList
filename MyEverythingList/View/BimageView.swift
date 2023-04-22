//
//  BimageView.swift
//  MyEverythingList
//
//  Created by Scarlett  on 4/22/23.
//

import SwiftUI

struct BimageView: View {
    let columns :[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @Binding var showimageview:Bool
    @AppStorage("imagename") var imagename:String?
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                Button {
                    showimageview = false
                } label: {
                    Image(systemName: "xmark").bold()
                        .font(.title2)
                        .foregroundColor(.black)
                }
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .padding()
                LazyVGrid(columns: columns){
                    ForEach(MacData.gallery){ items in
                        Image(items.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 115, height: 190)
                            .cornerRadius(10)
                            .onTapGesture {
                                imagename = items.imageName
                                showimageview = false
                            }
                    }
                   
                }
            }
            
        }
        
    }
}

struct BimageView_Previews: PreviewProvider {
    static var previews: some View {
        BimageView( showimageview: .constant(false))
    }
}
