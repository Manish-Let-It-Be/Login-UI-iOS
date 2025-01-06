import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var loginScreen = false
    @State private var isHovered = false
    @State private var isPasswordVisible = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.green.ignoresSafeArea()

                Circle()
                    .scale(1.8)
                    .foregroundColor(.white.opacity(0.25))
                Circle()
                    .scale(1.6)
                    .foregroundColor(.white.opacity(0.25))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)

                VStack(spacing: 20) {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 20)

                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.green)
                        TextField("Username", text: $username)
                            .disableAutocorrection(false)
                    }
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))

                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.green)

                
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }

                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongPassword))
                    .padding(.bottom, 20)

                    Button(action: {
                        AuthenticateUser(username: username, password: password)
                    }) {
                        HStack {
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Login")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(isHovered ? Color.green.opacity(0.9) : Color.green.opacity(0.78))
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        .scaleEffect(isHovered ? 1.05 : 1.0)
                        .animation(.easeInOut(duration: 1.9), value: isHovered)
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                isHovered = true
                            }
                            .onEnded { _ in
                                isHovered = false
                            }
                    )
                }
                .navigationDestination(isPresented: $loginScreen) {
                    LoggedInView()
                }
            }
        }
    }

    func AuthenticateUser(username: String, password: String) {
        if username == "Manish" {
            wrongUsername = 0
            if password == "923420" {
                wrongPassword = 0
                loginScreen = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
}

struct LoggedInView: View {
    var body: some View {
        VStack {
            Text("Welcome to your dashboard!")
                .font(.largeTitle)
                .bold()
                .padding()

            Spacer()

            HStack {
                Spacer()
                Button(action: {}) {
                    VStack {
                        Image(systemName: "person.fill")
                            .font(.largeTitle)
                        Text("Profile")
                            .font(.caption)
                    }
                }
                Spacer()
                Button(action: {}) {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .font(.largeTitle)
                        Text("Search")
                            .font(.caption)
                    }
                }
                Spacer()
                Button(action: {}) {
                    VStack {
                        Image(systemName: "gearshape.fill")
                            .font(.largeTitle)
                        Text("Settings")
                            .font(.caption)
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.1))
        }
        .navigationTitle("Welcome")
    }
}

#Preview {
    ContentView()
}

