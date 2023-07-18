//
//  SubListView.swift
//  ExampleApp
//
//  Created by shaik rehman on 7/10/23.
//

import SwiftUI

struct SubListView: View {
    @ObservedObject var serviceSubClass : ServiceClass
    let serviceName: String
    @State var showSheet = false
    var body: some View {
            List{
                ForEach(serviceSubClass.serviceSubList, id:\.name){ item in
                    NavigationLink{
                        FieldsView(pairs: item, serviceSubName: item.name)
                    }label: {
                        HStack{
                            if item.name == "Netflix"{
                                Image("netflix")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                            }
                            else{
                                Circle()
                                    .foregroundColor(.blue)
                                    .frame(width: 25, height: 25)
                                    .overlay(
                                        
                                        Text(item.name.capitalizeFirst)
                                            .font(.system(size: 14))
                                            .font(.headline.weight(.semibold))
                                            .foregroundColor(.white)
                                        
                                        
                                    )
                            }
                            Text(item.name)
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle(serviceName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditButton()
                Button{
                    showSheet = true
                }label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showSheet) {
                AddServiceSubView(services: $serviceSubClass.serviceSubList)
            }
    }
    
    func delete(at offSet: IndexSet){
        serviceSubClass.serviceSubList.remove(atOffsets: offSet)
    }
}

struct SubListView_Previews: PreviewProvider {
    static var previews: some View {
        SubListView(serviceSubClass: ServiceClass(service: "", serviceSubList: []), serviceName: "")
    }
}

extension String{
    var capitalizeFirst: String{
        self.prefix(1).capitalized
    }
}
