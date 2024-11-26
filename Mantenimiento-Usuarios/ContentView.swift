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

class ModelUsuarios: ObservableObject {
    @Published var listaUsuarios: [Usuario] = [
        Usuario(nombre: "Toki", email: "asumatoki04@hotmail.com")
    ]
}

struct ContentView: View {
    @StateObject var modeloGlobal = ModelUsuarios()
    
    var body: some View {
        NavigationView {
            
        }
    }
}
