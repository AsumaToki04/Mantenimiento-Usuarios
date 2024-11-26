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
    @Published var listaUsuarios: [Usuario] = []
    
    func archivoURL() -> URL {
        let documentos = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
        return documentos.appendingPathExtension("usuarios.json")
    }
    
    func guardarDatos() {
        do {
            let datos = try JSONEncoder().encode(listaUsuarios)
            try datos.write(to: archivoURL())
        } catch {
            print("Error al guardar datos: \(error)")
        }
    }
    
    func cargarDatos() {
        do {
            let datos = try Data(contentsOf: archivoURL())
            listaUsuarios = try JSONDecoder().decode([Usuario].self, from: datos)
        } catch {
            print("Error al cargar datos: \(error)")
        }
    }
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
    @State private var mostrarSheet = false
    
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
                .onDelete { indices in
                    modelo.listaUsuarios.remove(atOffsets: indices)
                    modelo.guardarDatos()
                }
            }
            .navigationTitle("Usuarios")
            .toolbar {
                Button(action: {
                    mostrarSheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $mostrarSheet) {
                RegistroUsuarios(modelo: modelo, mostrarSheet: $mostrarSheet)
            }
            .onAppear {
                modelo.cargarDatos()
            }
        }
    }
}

struct RegistroUsuarios: View {
    @ObservedObject var modelo: ModelUsuarios
    @Binding var mostrarSheet: Bool
    
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
                    modelo.guardarDatos()
                    mostrarSheet = false
                }
            }
            .navigationTitle("Registro de Usuario")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        mostrarSheet = false
                    }
                }
            }
        }
    }
}
