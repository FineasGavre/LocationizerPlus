//
//  EditLocationDetailView.swift
//  LocationizerPlus
//
//  Created by Fineas Gavre on 16.09.2020.
//

import SwiftUI

struct EditLocationDetailView: View {
    
    // MARK: - Public Properties
    
    @Binding var isViewShown: Bool
    var location: Location
    
    // MARK: - Private Properties
    
    @State private var name = ""
    @State private var address = ""
    @State private var longitude = ""
    @State private var latitude = ""
    @State private var imageURL = ""
    
    @State private var isFormError = false
    @State private var errorText = ""
    
    // MARK: - View Body
    
    var body: some View {
        Form {
            Section(header: Text("INFORMATION")) {
                TextField("Name", text: $name)
                    .disabled(true)
                    .foregroundColor(.gray)
                TextField("Address", text: $address)
            }
            Section(header: Text("LOCATION")) {
                TextField("Longitude", text: $longitude)
                    .keyboardType(.decimalPad)
                TextField("Latitude", text: $latitude)
                    .keyboardType(.decimalPad)
            }
            Section(header: Text("IMAGE")) {
                TextField("Image URL", text: $imageURL)
                    .keyboardType(.URL)
            }.alert(isPresented: $isFormError, content: {
                Alert(title: Text("Error"), message: Text(errorText), dismissButton: .default(Text("Close")))
            })
        }.listStyle(PlainListStyle())
        .navigationTitle("Edit Location")
        .navigationBarItems(trailing: Button("Save") {
            submitEditForm()
        })
        .onAppear {
            fillInformation()
        }
    }
    
    // MARK: - Private Methods
    
    private func fillInformation() {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        
        name = location.label
        address = location.address
        longitude = formatter.string(from: NSNumber(value: location.longitude)) ?? ""
        latitude = formatter.string(from: NSNumber(value: location.latitude)) ?? ""
        imageURL = location.image ?? ""
    }
    
    private func submitEditForm() {
        guard !name.isEmpty, !address.isEmpty, !longitude.isEmpty, !latitude.isEmpty else {
            isFormError.toggle()
            errorText = "Fields cannot be empty."
            return
        }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        
        guard let latitude = formatter.number(from: latitude)?.doubleValue, let longitute = formatter.number(from: longitude)?.doubleValue else {
            isFormError.toggle()
            errorText = "Coordinates need to be in decimal form."
            return
        }
        
        guard URL(string: imageURL) != nil || imageURL.isEmpty else {
            isFormError.toggle()
            errorText = "Invalid image URL provided."
            return
        }
        
        let location = RealmLocation()
        location.id = name
        location.label = name
        location.address = address
        location.longitude = longitute
        location.latitude = latitude
        location.image = imageURL != "" ? imageURL : nil
        
        do {
            try RealmHelper.shared.update(location)
        } catch {
            isFormError.toggle()
            errorText = "An error has occured when updating the database."
            return
        }

        isViewShown = false
    }
}
