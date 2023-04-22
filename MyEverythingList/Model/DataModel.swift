//
//  DataModel.swift
//  MyEverythingList
//
//  Created by Scarlett  on 4/22/23.
//

import Foundation
var icons : [String] = ["folder.fill","paperplane.fill","books.vertical.fill","backpack.fill","figure.badminton","trophy.fill","power.dotted","delete.backward.fill","zzz","cloud.drizzle.fill","star.square.on.square.fill","phone.circle.fill","house","video.and.waveform","questionmark.folder","wrench.and.screwdriver","tshirt.fill","alarm","pill.circle","gamecontroller.fill", "airplane.departure","tram.fill","bicycle","cart.fill.badge.questionmark"]


struct Gallery : Identifiable{
    var id = UUID()
    var imageName : String
}
struct MacData {
    static var gallery: [Gallery] = [
        Gallery(imageName: "im1"),
        Gallery(imageName: "im2"),
        Gallery(imageName: "im3"),
        Gallery(imageName: "im4"),
        Gallery(imageName: "im5"),
        Gallery(imageName: "im6"),
        Gallery(imageName: "im7"),
        Gallery(imageName: "im10")
    ]
}

struct EverythingListModel:Identifiable{
    var id : String
    var isCompleted : Bool = false
    var title : String
    var icon : String
}
