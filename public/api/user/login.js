// This is a static JavaScript file that simulates API responses
// For a real backend, you'd need Firebase Functions or a server

// Mock API response for login
const loginResponse = {
    status: true,
    message: 'Login successful',
    data: {
        user: {
            id: 'user_' + Date.now(),
            email: 'user@example.com',
            name: 'Test User'
        },
        token: 'token_' + Math.random().toString(36).substr(2, 9)
    }
};

// Export for use
if (typeof module !== 'undefined' && module.exports) {
    module.exports = loginResponse;
}



