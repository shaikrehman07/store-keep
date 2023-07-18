//
//  AddServiceSubView.swift
//  ExampleApp
//
//  Created by shaik rehman on 7/10/23.
//

import SwiftUI

struct AddServiceSubView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var services: [SubList]
    
    @State var serviceName = ""
    @State var key = ""
    @State var value = ""
    @State var showError = false
    var body: some View {
        VStack{
            VStack(spacing: 15){
                if showError{
                    Text("Please fill all fields").font(.caption).foregroundColor(.red).font(.system(size: 12))
                }
                VStack(alignment: .leading, spacing: 6){
                    Text("Add Service").font(.system(size: 25)).fontWeight(.medium).font(.headline)
                    TextField("name", text: $serviceName).padding([.horizontal, .vertical], 8).overlay(
                        RoundedRectangle(cornerRadius: 4).stroke(.blue, lineWidth: 1)
                    )
                }
                HStack{
                    Image(systemName: "exclamationmark.triangle.fill").font(.system(size: 14)).foregroundColor(.gray).padding(.trailing, 4)
                    Text("One key-value is mandatory.").font(.caption).foregroundColor(.gray).font(.system(size: 14))
                    
                }
                VStack(alignment: .leading, spacing: 6){
                    Text("Key").font(.system(size: 18)).fontWeight(.medium).font(.subheadline)
                    TextField("key", text: $key).padding([.horizontal, .vertical], 8).overlay(
                        RoundedRectangle(cornerRadius: 4).stroke(.blue, lineWidth: 1)
                    )
                }
                VStack(alignment: .leading, spacing: 6){
                    Text("Value").font(.system(size: 18)).fontWeight(.medium).font(.subheadline)
                    TextField("value", text: $value).padding([.horizontal, .vertical], 8).overlay(
                        RoundedRectangle(cornerRadius: 4).stroke(.blue, lineWidth: 1)
                    )
                }
            }
            .padding()
            
            HStack(alignment: .center){
                Button{
                    if validFields{
                        let subList = SubList(name: serviceName, fields: [Pair(key: key, value: value)])
                        services.append(subList)
                        
                        dismiss()
                        
                        showError = false
                    }else{
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
    
    var validFields : Bool{
        if serviceName.isEmpty || key.isEmpty || value.isEmpty{
            return false
        }
        return true
    }
}

struct AddServiceSubView_Previews: PreviewProvider {
    static var previews: some View {
        AddServiceSubView(services: .constant(SubList.sampleData))
    }
}
