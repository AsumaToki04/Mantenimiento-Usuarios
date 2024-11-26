//
//  ContentView.swift
//  Mantenimiento-Usuarios
//
//  Created by DAMII on 25/11/24.
//

import SwiftUI

struct Usuario: Codable, Identifiable {
    let id: UUID
    let nombre: String
    let email: String
    
    init(id: UUID = UUID(), nombre: String, email: String) {
        self.id = id
        self.nombre = nombre
        self.email = email
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
