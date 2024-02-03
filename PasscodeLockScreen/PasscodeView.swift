import SwiftUI

struct PasscodeView: View {
    
    @Binding var isAuthenticated: Bool
    @State private var passcode = ""
    
    var body: some View {
        VStack(spacing: 48) {
            VStack(spacing: 24) {
                Text("Enter Passcode").font(.largeTitle).fontWeight(.heavy)
                Text("Please enter your 4-digit pin to securely access your account.").font(.subheadline).multilineTextAlignment(.center)
            }
            .padding(.top)
            
            PasscodeIndicatorView(passcode: $passcode)
            
            Spacer()
            
            NumberPadView(passcode: $passcode)
            
                .onChange(of: passcode, perform: { value in
                    verifyPasscode()
                })
        }
    }
    
    private func verifyPasscode() {
        guard passcode.count == 4 else { return }
        Task {
            try? await Task.sleep(nanoseconds: 125_000_000)
            isAuthenticated = passcode == "1111"
            passcode = ""
        }
    }
}

struct PasscodeView_Previews: PreviewProvider {
    static var previews: some View {
        PasscodeView(isAuthenticated: .constant(false))
    }
}
