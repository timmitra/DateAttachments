//
// ---------------------------- //
// Original Project: Dates
// Created on 2024-09-24 by Tim Mitra
// Mastodon: @timmitra@mastodon.social
// Twitter/X: timmitra@twitter.com
// Web site: https://www.it-guy.com
// ---------------------------- //
// Copyright © 2024 iT Guy Technologies. All rights reserved.
/* https://stackoverflow.com/questions/77689616/how-to-create-entity-with-attachment-using-realityview-in-visionos
 */


import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var objects: [Date:Entity] = [:]

    var body: some View {
        VStack {
            RealityView { content, attachments in
               if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    content.add(scene)
                }
            } update: { content, attachments in
                
                objects.keys.forEach { key in
                    
                    if let entity = objects[key],
                        let attachment = attachments.entity(for: key) {
                        content.add(entity)
                        entity.addChild(attachment)
                    }
                }
            } attachments: {
                ForEach(Array(objects.keys), id: \.self) { key in
                    Attachment(id: key) {
                        Text(key.description)
                    }
                }
            }
            
            VStack {
                Button(action: {
                    let entity = Entity()
                    entity.setPosition([
                        0,-0.20 + (Float(objects.count) * 0.025), 0
                    ], relativeTo: nil)
                    objects[Date.now] = entity
                }, label: {
                    Text("Insert Object!")
                })
                
            }


        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
