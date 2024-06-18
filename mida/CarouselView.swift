//
//  CarouselView.swift
//  EcoFonts
//
//  Created by bael.ryspekov on 10.06.2024.
//

import SwiftUI

struct CarousalView: View {
    
    @GestureState private var dragState = DragState.inactive
    @State var carousalLocation = 0
    
    var itemHeight: CGFloat
    var views: [AnyView]
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                ForEach(0..<views.count * 3, id: \.self) { i in
                    VStack {
                        self.views[i % views.count]
                            .frame(width: 200, height: getHeight(i))
                            .animation(.interpolatingSpring(stiffness: 200, damping: 30, initialVelocity: 10))
                            .background(Color.white)
                            .cornerRadius(15)
                            .opacity(getOpacity(i))
                            .offset(x: getOffset(i))
                            .animation(.interpolatingSpring(stiffness: 200, damping: 30, initialVelocity: 10))
                    }
                }
            }
            .gesture(
                DragGesture()
                    .updating($dragState) { drag, state, _ in
                        state = .dragging(translation: drag.translation)
                    }
                    .onEnded { drag in
                        self.onDragEnded(drag: drag)
                    }
            )
            .onAppear {
                startAutoScroll()
            }
            
            Text("Generation...")
                .font(.system(size: 20, weight: .semibold))
            
        }
    }
    
    func startAutoScroll() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            carousalLocation = (carousalLocation + 1) % views.count
        }
    }

    private func onDragEnded(drag: DragGesture.Value) {
        let dragThreshold: CGFloat = 100
        if drag.predictedEndTranslation.width > dragThreshold || drag.translation.width > dragThreshold {
            carousalLocation = (carousalLocation - 1 + views.count) % views.count
        } else if drag.predictedEndTranslation.width < -dragThreshold || drag.translation.width < -dragThreshold {
            carousalLocation = (carousalLocation + 1) % views.count
        }
    }
    
    func relativeLoc() -> Int {
        return ((views.count * 10000) + carousalLocation) % views.count
    }
    
    func getOffset(_ i: Int) -> CGFloat {
        let index = i % views.count
        let relativeIndex = (views.count * 10000 + carousalLocation) % views.count

        if index == relativeIndex {
            return dragState.translation.width
        } else if index == (relativeIndex + 1) % views.count {
            return dragState.translation.width + (200 + 20)
        } else if index == (relativeIndex - 1 + views.count) % views.count {
            return dragState.translation.width - (200 + 20)
        } else if index == (relativeIndex + 2) % views.count {
            return dragState.translation.width + 2 * (200 + 20)
        } else if index == (relativeIndex - 2 + views.count) % views.count {
            return dragState.translation.width - 2 * (200 + 20)
        } else if index == (relativeIndex + 3) % views.count {
            return dragState.translation.width + 3 * (200 + 20)
        } else if index == (relativeIndex - 3 + views.count) % views.count {
            return dragState.translation.width - 3 * (200 + 20)
        } else {
            return 10000
        }
    }
    
    func getHeight(_ i: Int) -> CGFloat {
        let index = i % views.count
        if index == relativeLoc() {
            return itemHeight
        }
        return itemHeight - 100
    }
    
    func getOpacity(_ i: Int) -> Double {
        let index = i % views.count
        let relativeIndex = relativeLoc()
        
        if index == relativeIndex
            || index == (relativeIndex + 1) % views.count
            || index == (relativeIndex - 1 + views.count) % views.count
            || index == (relativeIndex + 2) % views.count
            || index == (relativeIndex - 2 + views.count) % views.count {
            return 1
        }
        return 0
    }
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

func imageView(name: String) -> some View {
    Image(name)
        .resizable()
}

func getViews() -> [AnyView] {
    let images: [String] = [
        "1", "2", "3", "4", "5", "6", "7", "8"
    ]
    
    var views: [AnyView] = []
    
    for image in images {
        views.append(AnyView(imageView(name: image)))
    }
    
    return views
}

#Preview(body: {
    CarousalView(itemHeight: 300, views: getViews())
})

