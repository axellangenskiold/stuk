import SwiftUI

struct CardView: View {
    @Binding var path: NavigationPath
    
    @State private var isFlipped = true
    @State var frontDegree = 0.0
    @State var backDegree = -90.0
    let durationDelay: CGFloat = 0.15
    @State var isLoadingCard = false // State to track if loading card is shown
    @State var isShowingQR = false // State to track if the QR image is shown
    
    @State var circle: Int = 1
    
    var body: some View {
        ZStack {
            MovingBackground()
        
            VStack {
                Spacer()
                ZStack {
                    FlipableCardView(degree: $frontDegree, isFake: false, circle: $circle)
                    FlipableCardView(degree: $backDegree, isFake: true, circle: $circle)
                }
                .onTapGesture {
                    flipCard()
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width > 50 {
                                // Swipe right
                                if circle == 3 {
                                    circle = 2
                                }
                                else if circle == 2 {
                                    circle = 1
                                }
                            } else if value.translation.width < -50 {
                                // Swipe left
                                if circle == 1 {
                                    circle = 2
                                }
                                else if circle == 2 {
                                    circle = 3
                                }
                            }
                        }
                )
                .padding(.bottom, 100)
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Button(action: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            path.removeLast()
                        }
                    }) {
                        Text("Stäng")
                            .foregroundStyle(.white)
                            .font(.custom("Arial", size: 20))
                            .padding(.leading, 0)
                            .padding(.trailing, 48)
                    }
                    
                    Button(action: {
                        circle = 1
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 32)
                                .foregroundStyle(circle == 1 ? .white : .black)
                            
                            Text("1")
                                .foregroundStyle(circle == 1 ? .black : .white)
                            
                        }
                        .padding(.trailing, 0)
                    }
                    .disabled(circle == 1)
                    
                    Button(action: {
                        circle = 2
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 32)
                                .foregroundStyle(circle == 2 ? .white : .black)
                            
                            Text("2")
                                .foregroundStyle(circle == 2 ? .black : .white)
                            
                        }
                        .padding(.horizontal, 0)
                    }
                    .disabled(circle == 2)
                    
                    Button(action: {
                        circle = 3
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 32)
                                .foregroundStyle(circle == 3 ? .white : .black)
                            
                            Text("3")
                                .foregroundStyle(circle == 3 ? .black : .white)
                            
                        }
                        .padding(.leading, 0)
                    }
                    .disabled(circle == 3)
                    
                    Image("qr")
                        .resizable()
                        .frame(width: 29, height: 29)
                        .padding(.leading, 48)
                        .onTapGesture {
                            withAnimation {
                                isShowingQR = true // Show the QR card when QR image is pressed
                            }
                        }
                    
                    Image("refresh")
                        .resizable()
                        .frame(width: 30, height: 35)
                        .onTapGesture {
                            showLoadingCard() // Show loading card when refresh is pressed
                        }
                }
            }
            
            // Show the QR card full screen when isShowingQR is true
            if isShowingQR {
                ZStack {
                    Color.black.opacity(0.7)
                    
                    VStack {
                        Image("qrcard")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 370)
                            .onTapGesture {
                                // Prevent the card from closing when it's tapped
                            }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    // Close the QR card when tapping outside the image
                    withAnimation {
                        isShowingQR = false
                    }
                }
            }
            
            // Show the loading card when isLoadingCard is true
            if isLoadingCard {
                ZStack {
                    Color.STUK_GRAY.opacity(1)
                    
                    VStack {
                        Image("loadingcard")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func flipCard() {
        isFlipped = !isFlipped
        if !isFlipped {
            withAnimation(.linear(duration: durationDelay)) {
                frontDegree = 90
            }
            withAnimation(.linear(duration: durationDelay)
                .delay(durationDelay)) {
                    backDegree = 0
                }
            
        } else {
            withAnimation(.linear(duration: durationDelay)) {
                backDegree = -90
            }
            withAnimation(.linear(duration: durationDelay)
                .delay(durationDelay)) {
                    frontDegree = 0
                }
        }
    }
    
    func showLoadingCard() {
        isLoadingCard = true
        
        // Automatically close the loading card after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                isLoadingCard = false
            }
        }
    }
}

#Preview {
    CardView(path: .constant(NavigationPath()))
}
