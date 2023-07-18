//
//  AddServiceView.swift
//  ExampleApp
//
//  Created by shaik rehman on 7/10/23.
//

import SwiftUI

struct AddServiceView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var services: [ServiceClass]
    
    @State var serviceName = ""
    @State var showError = false
    
    var validFields : Bool{
        if serviceName.isEmpty{
            return false
        }
        return true
    }
    
    var body: some View {
        VStack{
            if showError{
                Text("Please enter name").font(.caption).foregroundColor(.red).font(.system(size: 12))
            }
            VStack(alignment: .leading){
                Text("Service Name").font(.system(size: 25)).fontWeight(.medium).font(.headline)
                TextField("name", text: $serviceName).padding().overlay(
                    RoundedRectangle(cornerRadius: 4).stroke(.blue, lineWidth: 1)
                )
            }
            .padding()
            
            HStack(alignment: .center){
                Button{
                    if validFields{
                        let service = ServiceClass(service: serviceName, serviceSubList: [SubList]())
                        services.append(service)
                        
                        dismiss()
                        showError = false
                    }
                    else{
                        showError = true
                    }
                }label: {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(Font.system(size: 30, weight: .semibold))
                        .padding()
                        
                }
                
                Button{
                    dismiss()
                    showError = false
                }label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                        .font(Font.system(size: 30, weight: .semibold))
                        .padding()
                }
            }
        }
    }
}

struct AddServiceView_Previews: PreviewProvider {
    static var previews: some View {
        AddServiceView(services: .constant(ServiceClass.sampleData))
    }
}
