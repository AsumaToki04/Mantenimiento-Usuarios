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
            ListaUsuarios(modelo: modeloGlobal)
        }
    }
}

struct ListaUsuarios: View {
    @ObservedObject var modelo: ModelUsuarios
    
    var body: some View {
        VStack {
            List {
                ForEach(modelo.listaUsuarios) { item in
                    VStack {
                        Text(item.nombre)
                            .font(.headline)
                        Text(item.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Usuarios")
        }
    }
}

struct RegistroUsuarios: View {
    @ObservedObject var modelo: ModelUsuarios
    
    @State private var nombre: String = ""
    @State private var email: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre", text: $nombre)
                TextField("Email", text: $email)
                
                Button("Guardar") {
                    let nuevo = Usuario(nombre: nombre, email: email)
                    modelo.listaUsuarios.append(nuevo)
                }
            }
            .navigationTitle("Registro de Usuario")
        }
    }
}
