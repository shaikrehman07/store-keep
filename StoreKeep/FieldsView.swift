//
//  FieldsView.swift
//  ExampleApp
//
//  Created by shaik rehman on 7/10/23.
//

import SwiftUI

struct FieldsView: View {
    @ObservedObject var pairs : SubList
    let serviceSubName: String
    @State var showSheet = false
    @State var editMode = false
    @State var selectedField = Pair(key: "", value: "")
    var body: some View {
            List{
                ForEach(pairs.fields, id:\.key){ item in
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(item.key)").font(.headline).font(.system(size: 12))
                            if let stringValue = item.value as? String {
                                Text("\(stringValue)").font(.subheadline).font(.system(size: 10))
                            }
                            
                        }
                        
                        Spacer()
                        
                        Button {
                                selectedField = item
                                showSheet = true
                                editMode = true
                            } label: {
                                Image(systemName: "pencil.circle")
                            }
                        
                        
                            Image(systemName: "trash")
                            .foregroundColor(.red)
                                .onTapGesture {
                                    delete(item: item)
                                }
                        
                    }
                    
                }
        }
        .navigationTitle(serviceSubName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            Button{
                showSheet = true
            }label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showSheet) {
            AddFieldsView(services: $pairs.fields, editMode: $editMode, selectedPair : $selectedField)
        }
    }
    
    func delete(item : Pair){
        withAnimation{
            pairs.fields.removeAll{$0.key == item.key}
        }
    }
}

struct FieldsView_Previews: PreviewProvider {
    static var previews: some View {
        FieldsView(pairs: SubList.sampleData[0], serviceSubName: "", selectedField: Pair(key: "", value: "") )
    }
}
