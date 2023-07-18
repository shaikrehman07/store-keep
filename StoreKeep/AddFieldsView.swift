//
//  AddFieldsView.swift
//  ExampleApp
//
//  Created by shaik rehman on 7/10/23.
//

import SwiftUI

struct AddFieldsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var services: [Pair]
    @Binding var editMode : Bool
    @Binding var selectedPair : Pair
    @State var key = ""
    @State var value = ""
    @State var showError = false
    
    var validFields : Bool{
        if key.isEmpty || value.isEmpty{
            return false
        }
        return true
    }
    
    var body: some View {
        VStack{
            VStack(spacing: 15){
                if showError{
                    Text("Please fill both fields").font(.caption).foregroundColor(.red).font(.system(size: 12))
                }
                
                VStack(alignment: .leading, spacing: 6){
                    Text("Key").font(.system(size: 22)).fontWeight(.medium).font(.headline)
                    TextField("key", text: $key).padding([.horizontal, .vertical], 8).overlay(
                        RoundedRectangle(cornerRadius: 4).stroke(.blue, lineWidth: 1)
                    )
                }
                    
                VStack(alignment: .leading, spacing: 6){
                    Text("Value").font(.system(size: 22)).fontWeight(.medium).font(.headline)
                    TextField("value", text: $value).padding([.horizontal, .vertical], 8).overlay(
                        RoundedRectangle(cornerRadius: 4).stroke(.blue, lineWidth: 1)
                    )
                }
            }
            .padding()
            .onAppear{
                if editMode{
                    key = selectedPair.key
                    value = String(describing: selectedPair.value)
                }
            }
            
            HStack(alignment: .center){
                Button{
                    if validFields{
                        if editMode{
                            let _ = services.enumerated().map { (index, pair) in
                                if pair.key == selectedPair.key{
                                    print(pair.key)
                                    services[index] = Pair(key: key, value: value)
                                }
                            }
                            
                            editMode = false
                        }
                        else{
                            let pair = Pair(key: key, value: value)
                            services.append(pair)
                        }
                        
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
                    editMode = false
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

struct AddFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        AddFieldsView(services: .constant(Pair.sampleData), editMode: .constant(false), selectedPair: .constant(Pair(key: "", value: "")))
    }
}
