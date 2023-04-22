//
//  AddNewList.swift
//  MyEverythingList
//
//  Created by Scarlett  on 4/22/23.
//

import SwiftUI

struct AddNewList: View {
    @State  var inputText: String = ""
    @Binding var isPresented: Bool
    @State var iconselcted = "folder.fill"
    var columns:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @EnvironmentObject var signInViewModel : FirebaseFunctions
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 310)
            .foregroundColor(.white)
            .overlay(content: {
                VStack(spacing: 10){
                    HStack{
                        Button(action: {
                            isPresented = false
                        }, label: {
                            Image(systemName: "xmark").bold()
                                .imageScale(.large)
                                .foregroundColor(.black)
                        })
                        Spacer()
                        
                        Button(action: {
                            if !inputText.isEmpty{
                                signInViewModel.SaveTask(titel: inputText, isCompled: signInViewModel.isCompleted, icon: iconselcted)
                                inputText = ""
                                isPresented = false
                            }
                        }, label: {
                            Text("Save").bold()
                                .font(.title3)
                                .foregroundColor(.black)
                        })
                        .buttonStyle(.bordered)
                    }
                    
                    .padding(.top)
                    HStack(spacing: 10){
                        Image(systemName: iconselcted)
                            .imageScale(.large)
                            .foregroundColor(.black)
                            .frame(width: 35, height: 40)
                        TextField("Enter item", text: $inputText).bold()
                            .font(.largeTitle)
                            .foregroundColor(.black)
                    }
                    ScrollView(.vertical,showsIndicators: false){
                        LazyVGrid(columns: columns, content: {
                            ForEach(icons,id: \.self){item in
                                ZStack{
                                    Image(systemName: item)
                                        .imageScale(.medium)
                                        .foregroundColor(.black)
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(iconselcted == item ? .black : .clear)
                                }
                                .onTapGesture{
                                    iconselcted = item
                                }
                            }
                        })
                        .padding(.top)
                    }
                    .background(.black.opacity(0.1))
                    .cornerRadius(10)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
            })
            .padding(.horizontal)
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 0)
        
    }
}

struct AddNewList_Previews: PreviewProvider {
    static var previews: some View {
        AddNewList(isPresented: .constant(false))
            .environmentObject(FirebaseFunctions())
    }
}
