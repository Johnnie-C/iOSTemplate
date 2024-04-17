// **********************************************************
//    Copyright © 2023 Johnnie Cheng. All rights reserved.
// **********************************************************

import SwiftUI
import Common

struct SortableListDemoView: View {
    
    @State var editMode = EditMode.inactive
    @State private var draggedColor: Color?
    @State private var colors: [Color] = [
        .purple,
        .blue,
        .green,
        .yellow,
        .orange,
        .red
    ]
    
    var body: some View {
        VStack {
            if editMode == .inactive {
                normalList
            } else {
                editingList
            }
        }
        .listStyle(.plain)
        .environment(\.editMode, $editMode)
        .navigationBarTitle("Sortable List")
        .rightItem(editMode == .inactive ? editButton : doneButton)
        .background(.backgroundColor)
    }
    
    private var normalList: some View {
        ScrollView(showsIndicators: false) {
            VStack(commonSpacing: .small) {
                ForEach(colors, id: \.self) { color in
                    ItemView(color: color)
                        .onDrag {
                            self.draggedColor = color
                            return NSItemProvider()
                        }
                        .onDrop(
                            of: [.text],
                            delegate: DropViewDelegate(
                                destinationItem: color,
                                colors: $colors,
                                draggedItem: $draggedColor
                            )
                        )
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, .xSmall)
        }
    }
    
    private var editingList: some View {
        List {
            ForEach(colors, id: \.self) { color in
                ItemView(color: color)
                    .listRowSeparator(.hidden)
            }
            .onMove { self.colors.move(fromOffsets: $0, toOffset: $1) }
            .onDelete {
                if let index = $0.first {
                    self.colors.remove(at: index)
                }
            }
        }
    }
    
    private var editButton: Common.NavigationBarItem {
        .init(icon: .system("square.and.pencil")) {
            withAnimation { editMode = .active }
        }
    }
    
    private var doneButton: Common.NavigationBarItem {
        .init(title: .done, style: .done) {
            withAnimation { editMode = .inactive }
        }
    }
    
    struct ItemView: View {
        
        @Environment(\.editMode) var editMode
        var color: Color
        
        var body: some View {
            ZStack {
                color
                    .frame(minHeight: editMode?.wrappedValue == .inactive ? 100 : 30)
                    .fillWidth()
                    .cornerRadius(editMode?.wrappedValue == .inactive ? 20 : 5)
                HStack {
                    Text(color.description.capitalized)
                        .padding(.leading, editMode?.wrappedValue == .inactive ? .zero : .small)
                    if editMode?.wrappedValue == .active {
                        Spacer()
                    }
                }
                
            }
        }
        
    }
    
    struct DropViewDelegate: DropDelegate {
        
        let destinationItem: Color
        @Binding var colors: [Color]
        @Binding var draggedItem: Color?
        
        func dropUpdated(info: DropInfo) -> DropProposal? {
            return DropProposal(operation: .move)
        }
        
        func performDrop(info: DropInfo) -> Bool {
            draggedItem = nil
            return true
        }
        
        func dropEntered(info: DropInfo) {
            if let draggedItem = draggedItem,
               let fromIndex = colors.firstIndex(of: draggedItem),
               let toIndex = colors.firstIndex(of: destinationItem),
               fromIndex != toIndex {
                
                withAnimation {
                    self.colors.move(
                        fromOffsets: IndexSet(integer: fromIndex),
                        toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex)
                    )
                }
            }
        }
        
    }

}
