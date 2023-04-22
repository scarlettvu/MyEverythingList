//
//  HomePageView.swift
//  MyEverythingList
//
//  Created by Scarlett  on 4/22/23.
//

import SwiftUI

struct HomePageView: View {
    @AppStorage("imagename") var imagename:String?
    @State var showSignin = false
    @EnvironmentObject var singinViewmodel : FirebaseFunctions
    @State var Delet :Bool = false
    @State var sheet :Bool = false
    @State var Showimages = false
    @State var textfeld = ""
     
    var body: some View {
        ZStack{
            if showSignin == false{
                Image(imagename ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)

                    .ignoresSafeArea()
            }
            
            if showSignin{
                SignInView(showview: $showSignin)
            }else{
                VStack{
                    HStack{
                        Button {
                            withAnimation {
                                Delet.toggle()
                            }
                           
                        } label: {
                            Image(systemName:"pencil.slash")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        Button {
                            withAnimation {
                                Showimages.toggle()
                            }
                           
                        } label: {
                            Image(systemName:"photo.stack")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        .padding(.leading,10)
                        Spacer()
                        Button {
                            do{
                                try AuthenticationManager.shared.signOut()
                                showSignin = true
                                print("signOut")
                            }catch{
                                fatalError()
                            }
                            
                        } label: {
                            Image(systemName:"person.fill.badge.minus")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(5)
                    .background(.white.opacity(0.5))
                    .cornerRadius(10)
                    ScrollView{
                        ForEach(singinViewmodel.everythingList){ items in
                            VStack(alignment: .leading, spacing: 10){
                                   HStack{
                                       Image(systemName: items.isCompleted ? "circle.inset.filled" : "circle")
                                           .imageScale(.large)
                                           .foregroundColor(.gray)
                                           .padding(.horizontal,5)
                                       Text(items.title)
                                           .font(.title2)
                                           .fontWeight(.bold)
                                           .foregroundColor(.white)
                                       Spacer()
                                       if Delet{
                                           Button(action: {
                                               singinViewmodel.DeletTask(toDelet: items)
                                           }, label: {
                                               Image(systemName: "trash")
                                                   .foregroundColor(.red.opacity(0.7))
                                                   .font(.headline)

                                           })
                                       }else{
                                           Image(systemName: items.icon)
                                               .foregroundColor(.white)
                                               .font(.headline)
                                       }
                                   }
                                   .padding(.horizontal,5)
                                   .frame(height: 40)
                                   .frame(maxWidth: .infinity)
                                   .background(.black)
                                   .cornerRadius(10)
                                   .onTapGesture {
                                       singinViewmodel.UpdateTask(upDate: items)
                                   }
                            }
                        }
                    }
                }
                .padding()
                if sheet{
                    AddNewList(inputText: textfeld, isPresented: $sheet)
                }
                Button {
                    sheet.toggle()
                } label: {
                    ZStack{
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.black)
                        Image(systemName: "plus")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                    }
                }
                .frame(maxHeight: .infinity,alignment:.bottom)
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.trailing)
            }
            
           
        }
        .sheet(isPresented: $Showimages, content: {
            BimageView(showImageView: $Showimages, imageName: _imagename )
        })
        .onAppear{
            let authuser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignin = authuser == nil
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(FirebaseFunctions())
    }
}
