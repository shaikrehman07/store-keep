//
//  ServiceView.swift
//  ExampleApp
//
//  Created by shaik rehman on 7/11/23.
//

import SwiftUI

struct ServiceView: View {
    @ObservedObject var services : Data
    @State var showSheet = false
    @Environment(\.scenePhase) private var scenePhase
    let saveAction : ()->Void
    
    @State var showDeleteIcon = false
    @Environment(\.editMode) var editMode
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(services.data, id:\.service){ item in
                        NavigationLink{
                            SubListView(serviceSubClass: item, serviceName: item.service)
                        }label: {
                            ZStack(alignment: .topTrailing){
                                    Text(item.service)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                        .frame(width: 140, height: 35)
                                        .padding()
                                        .background(.blue)
                            
                            if showDeleteIcon{
                                Image(systemName: "trash")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.gray)
                                    .padding([.horizontal,.vertical], 4)
                                    .onTapGesture {
                                        delete(item: item)
                                    }
                                    .background(.white)
                                    .clipShape(Circle())
                                    .padding([.horizontal,.vertical], 4)
                                
                            }

                                
                            }
                            .cornerRadius(10)
                            .padding()
                                    
                        }
                    }
                }
            }
            .navigationTitle("Store")
            .toolbar {
                Button{
                    showDeleteIcon.toggle()
                }label: {
                    if showDeleteIcon{
                        Text("Done")
                    }else{
                        Text("Edit")
                    }
                }
                
                Button{
                    showSheet = true
                }label: {
                    Image(systemName: "plus.circle.fill")
                        .fontWeight(.semibold)
                        
                }
            }
            .sheet(isPresented: $showSheet) {
                AddServiceView(services: $services.data)
            }
            
        }
        .onChange(of: scenePhase) { phase in
                    if phase == .inactive { saveAction() }
                }
    }
    
    func delete(item : ServiceClass){
        withAnimation{
            services.data.removeAll{$0.service == item.service}
        }
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView(services: Data(), saveAction: {})
    }
}
